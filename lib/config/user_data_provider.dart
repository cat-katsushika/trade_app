import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_app/config/user_preferences.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/user_data_model.dart';
import 'package:trade_app/repository/other_repository.dart';

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, UserData>((ref) {
  return UserDataNotifier();
});

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier() : super(const UserData());

  Future<void> navigateWithUserData(BuildContext context) async {
    //id,email,passwordが保存されていたらログイン
    if (await loadUserData() && await login()) {
      //ログインできたらstateを変更。splashScreen等で検知して画面遷移
      state = state.copyWith(isLogin: true);
    }
    debugPrint('[isLogin] ${state.isLogin}');
  }

  Future<bool> loadUserData() async {
    final userData = await UserPreferences.getUserData();
    if (userData['id'] != '' &&
        userData['email'] != '' &&
        userData['password'] != '') {
      state = state.copyWith(
        id: userData['id'] ?? '',
        email: userData['email'] ?? '',
        password: userData['password'] ?? '',
      );
      return true;
    } else {
      return false;
    }
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');
    if (accessToken != null && refreshToken != null) {
      state = state.copyWith(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    }
  }


  Future<void> fetchCampuses() async {
    final campuses = await OtherRepository.fetchCampuses();
    state = state.copyWith(
      campuses: campuses
    );
  }


  void setMailAndPW(String email, String password) {
    state = state.copyWith(
      email: email,
      password: password,
    );
  }

  Future<bool> login({BuildContext? context, String? errMsg}) async {
    final Dio dio = Dio();
    dio.interceptors.add(LogInterceptor());
    List<Cookie> cookies = [];
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    PersistCookieJar cookieJar =
        PersistCookieJar(storage: FileStorage("$appDocPath/.cookies/"));
    dio.interceptors.add(CookieManager(cookieJar));

    const String apiUrl = '${Url.apiUrl}auth/jwt/create/';
    debugPrint('[login] email: ${state.email} pass: ${state.password}');
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
        // トークンとクッキーを保存
        cookies = [
          ...cookies,
          Cookie('access_token', state.accessToken),
          Cookie('refresh_token', state.refreshToken)
        ];
        cookieJar.saveFromResponse(Url.uriHost, cookies);

        // 格納されたクッキーをプリントする処理
        List<Cookie> cookieList =
            await cookieJar.loadForRequest(Url.uriHost);
        debugPrint(cookieList.toString());

        //userIDは別で取得
        final id = await OtherRepository.getMyId();
        state = state.copyWith(id: id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Error: $e');
      if (errMsg != null && context != null) {
        if (!mounted) return false;
        //エラーでたらその旨を表示
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
