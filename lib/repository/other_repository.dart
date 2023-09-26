import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/campus_model.dart';

class OtherRepository{

  static Future<Dio> addCookie(Dio dio) async  {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    PersistCookieJar cookieJar = PersistCookieJar(storage: FileStorage("$appDocPath/.cookies/"));
    dio.interceptors.add(CookieManager(cookieJar));
    print(await cookieJar.loadForRequest(Url.uriHost));
    return dio;
  }

  static Future<String> getMyId() async {
    var dio = Dio();
    dio = await addCookie(dio);
    try {
      final response = await dio.get('${Url.apiUrl}auth/users/me/');
      if (response.statusCode == 200) {
        debugPrint('id: ${response.data['id']}');
        return response.data['id'];
      } else {
        debugPrint("idエラー: ${response.statusCode}");
        return '';
      }
    } catch (e) {
      debugPrint("idリクエストエラー: $e");
      return '';
    }
  }

  static Future<List<Campus>> fetchCampuses() async {
    Dio dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    dio.interceptors.add(LogInterceptor());
    final response = await dio.get('${Url.apiUrl}campus/'); // APIのエンドポイントを指定

    if (response.statusCode == 200) {
      List<dynamic> responseBody = response.data;
      return responseBody.map((dynamic item) => Campus.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load campuses');
    }
  }
}