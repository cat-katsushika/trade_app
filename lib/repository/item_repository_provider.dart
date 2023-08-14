// repository/item_repository.dart
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:trade_app/models/item_model.dart';

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository();
});

class ItemRepository {
  final Dio _dio = Dio();

  Future<List<Item>> fetchItems() async {
    // final itemList = <Item>[];
    try {
      print('a');
      final response = await _dio.get('https://2f338ce1-8358-4109-a88b-929d6bbbcd07.mock.pstmn.io');
      print('a');
      final data = response.data as List<dynamic>;
      print(data);
      final itemList = data.map((e) => Item.fromJson(e)).toList();
      print('a');
      return itemList;
    } catch (e) {
      print(e);
      throw Exception('Failed to load items');
    }
  }
}
