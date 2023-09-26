import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/models/post_item_model.dart';
import 'package:trade_app/repository/other_repository.dart';
import 'package:http_parser/http_parser.dart';

//商品一覧データを取得
class ItemRepository {
  static Future<bool> purchaseItem(String itemId) async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    dio = await OtherRepository.addCookie(dio);
    try {
      final response = await dio.put('${Url.apiUrl}items/$itemId/purchase/');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      Exception(err);
      return false;
    }
  }

  Future<List<Item>> fetchItems(Map<String, dynamic>? query) async {
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    const url = '${Url.apiUrl}items/';
    dio.interceptors.add(LogInterceptor());
    final response = await dio.get(
      url,
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



  static Future<void> createItemWithDio(Map<String, dynamic> itemData, List<File> imageFiles) async {
    var dio = Dio();
    const url = '${Url.apiUrl}items/';
    dio = await OtherRepository.addCookie(dio);

    final formData = FormData.fromMap({
      ...itemData,
      'images': imageFiles.asMap().entries.map((entry) {
        int order = entry.key + 1;  // order starts from 1
        File file = entry.value;
        return {
          'order': order,
          'photo_path': MultipartFile.fromFileSync(file.path),
        };
      }).toList(),
    });
    //
    final response = await dio.post(url, data: formData);

    if (response.statusCode == 201) {
      print('Item created successfully!');
    } else {
      throw Exception('Failed to create item: ${response.data}');
    }
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
