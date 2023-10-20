import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/repository/other_repository.dart';

//商品一覧データを取得
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

  static Future<bool> createItemWithDio(
      Map<String, dynamic> itemData, List<File> imageFiles) async {
    var dio = Dio();
    const url = '${Url.apiUrl}items/create/';
    dio = await OtherRepository.addCookie(dio);

    final formData = FormData.fromMap({
      ...itemData,
      'image_1': MultipartFile.fromFileSync(imageFiles.first.path),
      'image_2': MultipartFile.fromFileSync(imageFiles[1].path),
    });
    try {
      final response = await dio.post(url, data: formData);
      if (response.statusCode == 201) {
        debugPrint('Item created successfully!');
        return true;
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
      } else {
        // それ以外のエラーを出力
        debugPrint('Unexpected error: $e');
      }
    }
    return false;
  }

  // static Future<bool> exhibitItem(PostItem item) async {
  //   try {
  //     var dio = Dio();
  //     dio = await OtherRepository.addCookie(dio);
  //     await _prepareDio(dio);
  //
  //     List<MultipartFile> multipartImages = [];
  //     for (var image in item.images) {
  //       multipartImages.add(await MultipartFile.fromFile(
  //         image.path,
  //         filename: image.path.split('/').last,
  //         // contentType: MediaType.parse('image/jpeg'),
  //       ));
  //     }
  //     print(multipartImages.first.filename);
  //
  //
  //     FormData formData = FormData.fromMap({
  //       "receivable_campus": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  //       "images" : [
  //         {
  //           "order": 0,
  //           "photo_path": multipartImages.first,
  //         },
  //       ],
  //       "price": 500,
  //       "name": "ネーム",
  //       "description": "",
  //       "condition": "コンディション",
  //       "writing_state": ""
  //     });
  //
  //     final Response response = await dio.post(
  //       '${Url.apiUrl}items/',
  //       data: formData,
  //     );
  //
  //     return true;
  //   } catch (error) {
  //     debugPrint(error.toString());
  //     return false;
  //   }
  // }

  // static Future<void> _prepareDio(Dio dio) async {
  //   dio.options.baseUrl = _uriHost.toString();
  //   dio.options.connectTimeout = Duration(seconds: 5);
  //   dio.options.receiveTimeout = Duration(seconds: 3);
  // }

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
