import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/post_item_model.dart';

//商品一覧データを取得
class ItemRepository {
  final Dio _dio = Dio();

  Future<List<Item>> fetchItems(Map<String, dynamic>? query) async {
    const url = '${Url.apiUrl}items/';
    _dio.interceptors.add(LogInterceptor());
    final response = await _dio.get(
      url,
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data;
      log(jsonData.toString());
      return jsonData.map((itemData) => Item.fromJson(itemData)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  static final Uri _uriHost = Uri.parse(Url.apiUrl);

  static Future<bool> exhibitItem(PostItem item) async {
    //TODO:出品関数実装
    try {
      Dio dio = Dio();
      await _prepareDio(dio);

      List<MultipartFile> multipartImages = [];
      for (var image in item.images) {
        multipartImages.add(await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ));
      }
      FormData formData = FormData.fromMap({
        "top_images": multipartImages,
        "image_set": [
          {
            "photo": "string",
            "parent_item": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
          }
        ],
        "listing_status": "unpurchased",
        "price": 500,
        "name": "string",
        "description": "string",
        "condition": "new",
        "writing_state": "none",
        "seller": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "buyer": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "receivable_campus": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
      });

      final Response profile = await dio.post(
        'item/',
        data: formData,
      );

      return true;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }

  static Future<bool> updateMyProfile(
      String id, List<File> uploadTopImages) async {
    try {
      Dio dio = Dio();
      await _prepareDio(dio);

      List<MultipartFile> multipartImages = [];
      for (var image in uploadTopImages) {
        multipartImages.add(await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ));
      }

      FormData formData = FormData.fromMap({
        "top_images": multipartImages,
      });

      final Response profile = await dio.patch(
        '/api/profiles/$id',
        data: formData,
      );

      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  static Future<void> _prepareDio(Dio dio) async {
    dio.options.baseUrl = _uriHost.toString();
    dio.options.connectTimeout = Duration(seconds: 5);
    dio.options.receiveTimeout = Duration(seconds: 3);
  }

// static Future<void> postItem(PostItem item) async {
//   const url =
//       "${Url.apiUrl}items/"; // こちらのURLを実際のAPIのURLに置き換えてください
//   final dio = Dio();
//
//   try {
//     final response = await dio.post(
//       url,
//       data: jsonEncode(item.toJson()),
//       options: Options(
//         headers: {
//           "Content-Type": "application/json",
//         },
//       ),
//     );
//
//     if (response.statusCode == 201) {
//       debugPrint("Item successfully posted");
//     } else {
//       debugPrint("Error posting item: ${response.data}");
//     }
//   } catch (e) {
//     debugPrint("Exception: $e");
//   }
// }
}
