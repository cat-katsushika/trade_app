import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/user_data_model.dart';

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, UserData>((ref) {
  return UserDataNotifier();
});

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier() : super(const UserData());

  void setMailAndPW(String email, String password) {
    state = state.copyWith(
      email: email,
      password: password,
    );
  }

  Future<bool> login({required BuildContext context, String? errMsg}) async {
    final Dio dio = Dio();
    dio.interceptors.add(LogInterceptor());
    const String apiUrl = '${Url.apiUrl}auth/jwt/create/';
    debugPrint('login:${state.email} pass:${state.password}');
    try {
      final response = await dio.post(apiUrl, data: {
        'email': state.email,
        'password': state.password,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        state = state.copyWith(
          accessToken: data['access'],
          refreshToken: data['refresh'],
        );

        // トークンをShared Preferencesに保存
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', state.accessToken);
        await prefs.setString('refresh_token', state.refreshToken);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (errMsg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errMsg),
          ),
        );
      }
      return false;
    }
  }
}
