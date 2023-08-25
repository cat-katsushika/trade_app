import 'package:dio/dio.dart';
import 'package:trade_app/models/university_model.dart';

Future<List<University>> fetchUniversities() async {
  var dio = Dio();
  const endpoint = 'YOUR_API_ENDPOINT_HERE'; // ここにAPIのエンドポイントを入力してください

  try {
    Response response = await dio.get(endpoint);

    // レスポンスデータが存在し、リストとして取得できることを確認
    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((item) => University.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load universities');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}
