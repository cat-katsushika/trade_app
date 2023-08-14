import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/models/item_model.dart';
import 'package:trade_app/repository/item_repository_provider.dart';

// final itemProvider = FutureProvider<List<Item>>((ref) async {
//   var response = await Dio().get('https://2f338ce1-8358-4109-a88b-929d6bbbcd07.mock.pstmn.io');
//   final data = response.data;
//   return data.map((item) => Item.fromJson(item)).toList();
// });


final itemListProvider = FutureProvider<List<Item>>((ref) async {
  final repo = ref.read(itemRepositoryProvider);
  return repo.fetchItems();
});
