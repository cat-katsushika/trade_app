import 'package:dio/dio.dart';
import 'package:trade_app/models/item_model.dart';

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
}

