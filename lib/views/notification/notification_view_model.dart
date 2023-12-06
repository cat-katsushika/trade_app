import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/notification_model.dart';
import 'package:trade_app/repository/other_repository.dart';

final notificationViewModelProvider = StateNotifierProvider<
    NotificationViewModel, AsyncValue<List<NotificationModel>>>((ref) {
  return NotificationViewModel();
});

class NotificationViewModel extends StateNotifier<AsyncValue<List<NotificationModel>>> {

  NotificationViewModel() : super(const AsyncValue.loading()) {
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      var dio = Dio();
      dio = await OtherRepository.addCookie(dio);
      dio.interceptors.add(LogInterceptor());
      debugPrint('${Url.apiUrl}notification/');
      final response = await dio.get('${Url.apiUrl}notification/');
      final List<dynamic> data = response.data;
      final notifications = data.map((json) => NotificationModel.fromJson(json)).toList();
      state = AsyncValue.data(notifications);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
