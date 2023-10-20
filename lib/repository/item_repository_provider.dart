import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/repository/other_repository.dart';


class ItemRepository {
  static Future<String> purchaseItem(String itemId) async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    dio = await OtherRepository.addCookie(dio);
    try {
      final response = await dio.put('${Url.apiUrl}items/$itemId/purchase/');
      return 'true';
    } catch (e) {
      if (e is DioException) {
        Response? errorResponse = e.response;
        debugPrint('Error code: ${errorResponse!.statusCode}');
        debugPrint('Error message: ${errorResponse.statusMessage}');
        debugPrint('Error data: ${errorResponse.data}');
        return errorResponse.data['error'].toString();
      } else {
        Exception(e);
        return e.toString();
      }
    }
  }

//商品一覧データを取得
  Future<List<Item>> fetchItems(Map<String, dynamic>? query, String url) async {
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    dio.interceptors.add(LogInterceptor());
    try {
      final response = await dio.get(
        url,
        queryParameters: query,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        debugPrint(response.data.toString());
        debugPrint(jsonData.toString());
        return (jsonData['results'] as List)
            .map((itemData) => Item.fromJson(itemData as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      if (e is DioException) {
        Response? errorResponse = e.response;
        debugPrint('Error code: ${errorResponse!.statusCode}');
        debugPrint('Error message: ${errorResponse.statusMessage}');
        debugPrint('Error data: ${errorResponse.data}');
        throw Exception('Failed to load items');
      } else {
        throw Exception(e);
      }
    }
  }

  static Future<String> createItemWithDio(
      Map<String, dynamic> itemData, List<File> imageFiles) async {
    var dio = Dio();
    const url = '${Url.apiUrl}items/create/';
    Map<String, dynamic> imageData = {};
    dio = await OtherRepository.addCookie(dio);
    int i = 1;
    for (var img in imageFiles) {
      imageData.addAll({'image_$i': MultipartFile.fromFileSync(img.path)});
      i++;
    }
    final formData = FormData.fromMap({
      ...itemData,
      ...imageData,
    });
    try {
      final response = await dio.post(url, data: formData);
      if (response.statusCode == 201) {
        debugPrint('Item created successfully!');
        return 'true';
      } else {
        debugPrint(response.data);
        throw Exception('Failed to create item: ${response.data}');
      }
    } catch (e) {
      if (e is DioException) {
        // エラーレスポンスを取得
        Response? errorResponse = e.response;
        // エラーコードを出力
        debugPrint('Error code: ${errorResponse!.statusCode}');
        // エラーメッセージを出力
        debugPrint('Error message: ${errorResponse.statusMessage}');
        // エラーレスポンスの本文を出力
        debugPrint('Error data: $errorResponse');
        return '${errorResponse.data['error']}';
      } else {
        // それ以外のエラーを出力
        debugPrint('Unexpected error: $e');
      }
    }
    return '';
  }
}
