import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _userIdKey = 'user_id';
  static const String _studentNumberKey = 'student_number';
  static const String _emailKey = 'email';

  // ユーザーデータを保存
  static Future<void> saveUserData({
    required String id,
    required String studentNumber,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userIdKey, id);
    prefs.setString(_studentNumberKey, studentNumber);
    prefs.setString(_emailKey, email);
  }

  // ユーザーデータを取得
  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_userIdKey) ?? '';
    final studentNumber = prefs.getString(_studentNumberKey) ?? '';
    final email = prefs.getString(_emailKey) ?? '';
    return {
      'id': id,
      'studentNumber': studentNumber,
      'email': email,
    };
  }

  // ユーザーデータを削除
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_userIdKey);
    prefs.remove(_studentNumberKey);
    prefs.remove(_emailKey);
  }
}
