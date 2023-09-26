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

  Future<bool> registration({required String email, required String password, required String rePassword, required Function(String value) snackFunction}) async {
    try {
      final response = await _dio.post(
        _apiEndpoint,
        data: {
          'email': email,
          'password': password,
          're_password': rePassword,
        },
      );
      if (response.statusCode == 201) {
        debugPrint('registration successful: ${response.data}');
        snackFunction("登録に成功しました");
        return true;
      } else {
        debugPrint('registration failed: ${response.data}');
        snackFunction("登録に失敗しました${response.data}");
        return false;
      }
    } catch (e) {
      snackFunction("登録に失敗しました$e");
      debugPrint('Error during registration: $e');
      return false;
    }
  }
}
