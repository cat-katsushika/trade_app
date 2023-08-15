import 'package:flutter/material.dart';
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
      final response = await _dio.get('https://2f338ce1-8358-4109-a88b-929d6bbbcd07.mock.pstmn.io');
      final data = response.data as List<dynamic>;
      final itemList = data.map((e) => Item.fromJson(e)).toList();
      return itemList;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to load items');
    }
  }
}
