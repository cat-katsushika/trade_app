import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/repository/other_repository.dart';

class ItemRepository {
  static Future<void> patchItemData(String itemId, String endPoint) async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    dio = await OtherRepository.addCookie(dio);
    try {
      await dio.put('${Url.apiUrl}items/$itemId/$endPoint/');
    } catch (e) {
      throw Exception(e);
    }
  }

//商品一覧データを取得
  Future<List<Item>> fetchItems(String name, int page, String url) async {
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    dio.interceptors.add(LogInterceptor());
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          "name": name,
          "page": page,
        },
      );
      Map<String, dynamic> jsonData = response.data;
      debugPrint(response.data.toString());
      debugPrint(jsonData.toString());
      return (jsonData['results'] as List)
          .map((itemData) => Item.fromJson(itemData as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if ((e is DioException) && e.response!.statusCode == 404) {
        return [];
      }
      throw Exception(e);
    }
  }

  static Future<void> exhibitItem(
      Map<String, dynamic> itemData, List<File> imageFiles) async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
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
      print(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
