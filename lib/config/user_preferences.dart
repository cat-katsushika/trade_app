import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _userIdKey = 'user_id';
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';

  // ユーザーデータを保存
  static Future<void> saveUserData({
    required String id,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userIdKey, id);
    prefs.setString(_emailKey, email);
    prefs.setString(_passwordKey, password);
    debugPrint("[save] id: $id email: $email password: $password");
  }

  // ユーザーデータを取得
  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_userIdKey) ?? '';
    final email = prefs.getString(_emailKey) ?? '';
    final password= prefs.getString(_passwordKey) ?? '';
    debugPrint("[load] id: $id email: $email password: $password");
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  // ユーザーデータを削除
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_userIdKey);
    prefs.remove(_emailKey);
    prefs.remove(_passwordKey);
    debugPrint('clear user data');
  }

}
