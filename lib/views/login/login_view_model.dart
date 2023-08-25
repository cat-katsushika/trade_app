import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/models/user_model.dart';

final loginViewModelProvider = Provider<LoginViewModel>((ref) {
  return LoginViewModel();
});

class LoginViewModel {
  final Dio _dio = Dio();

  final String _apiEndpoint = 'https://example.com/api/login';

  Future<void> login(UserModel user) async {
    try {
      final response = await _dio.post(
        _apiEndpoint,
        data: {
          'email': user.email,
          'password': user.password,
        },
      );

      if (response.statusCode == 200) {
        print('Login successful: ${response.data}');
      } else {
        print('Login failed: ${response.data}');
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }
}
