import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/post_item_model.dart';

//商品一覧データを取得
class ItemRepository {
  final Dio _dio = Dio();

  Future<List<Item>> fetchItems(Map<String, dynamic>? query) async {
    const url='https://2f338ce1-8358-4109-a88b-929d6bbbcd07.mock.pstmn.io';
    _dio.interceptors.add(LogInterceptor());
    final response = await _dio.get(url, queryParameters: query);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data;
      return jsonData.map((itemData) => Item.fromJson(itemData)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  static Future<void> postItem(PostItem item) async {
    const url =
        "https://your-api-url.com/items"; // こちらのURLを実際のAPIのURLに置き換えてください
    final dio = Dio();

    try {
      final response = await dio.post(
        url,
        data: jsonEncode(item.toJson()),
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        debugPrint("Item successfully posted");
      } else {
        debugPrint("Error posting item: ${response.data}");
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
  }
}

