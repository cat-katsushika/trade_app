import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trade_app/models/message_model.dart';
import 'package:trade_app/repository/other_repository.dart';

class MessageRepository {

  Future<List<Message>> fetchMessages(String apiUrl) async {
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    try {
      dio.interceptors.add(LogInterceptor());
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        final List<Message> messages = (response.data as List)
            .map((data) => Message.fromJson(data))
            .toList();
        debugPrint('fetched messages');
        return messages;
      } else {
        throw Exception('Failed to fetch Messages');
      }
    } catch (e) {
      throw Exception('An error occurred');
    }
  }
  Future<bool> postMessage(String apiUrl, Message message) async {
    var dio = Dio();
    dio = await OtherRepository.addCookie(dio);
    try {
      dio.interceptors.add(LogInterceptor());
      final response = await dio.post(
        apiUrl,
        data: message.toJson(),
      );

      if (response.statusCode == 201) {
        debugPrint('Message posted successfully');
        return true;
      } else {
        throw Exception('Failed to post Message');
      }
    } catch (e) {
      throw Exception('An error occurred while posting Message: $e');
    }
  }
}
