import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/url.dart';

final registrationViewModelProvider = Provider<RegistrationViewModel>((ref) {
  return RegistrationViewModel();
});

class RegistrationViewModel {
  final Dio _dio = Dio();
  final String _apiEndpoint = '${Url.apiUrl}auth/users/';

  Future<bool> registration(
      {required String email,
      required String password,
      required String rePassword,
      required Function(String value) snackFunction}) async {
    try {
      _dio.interceptors.add(LogInterceptor());
      final response = await _dio.post(
        _apiEndpoint,
        data: {
          'email': email,
          'password': password,
          're_password': rePassword,
        },
      );

      debugPrint('registration successful: ${response.data}');
      snackFunction("登録に成功しました");
      return true;
    } catch (e) {
      if (e is DioException && (e.response != null)) {
        snackFunction("${e.response!.data['password'].join('\n')}");
      }
      return false;
    }
  }
}
