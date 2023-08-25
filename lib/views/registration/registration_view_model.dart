import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/models/user_model.dart';

final registrationViewModelProvider = Provider<RegistrationViewModel>((ref) {
  return RegistrationViewModel();
});

class RegistrationViewModel {
  final Dio _dio = Dio();

  final String _apiEndpoint = 'https://example.com/api/registration';

  Future<void> registration(UserModel user) async {
    try {
      final response = await _dio.post(
        _apiEndpoint,
        data: {
          'email': user.email,
          'password': user.password,
        },
      );

      if (response.statusCode == 200) {
        print('registration successful: ${response.data}');
      } else {
        print('registration failed: ${response.data}');
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }
}
