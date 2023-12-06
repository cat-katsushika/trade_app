import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/views/error/network_error_view.dart';
import 'notification_view_model.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({super.key});

  @override
  ConsumerState createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  @override
  void initState() {
    super.initState();
    ref.read(notificationViewModelProvider.notifier).fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsyncValue = ref.watch(notificationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.ghostWhiteColor,
        title: const Text('お知らせ'),
      ),
      body: notificationsAsyncValue.when(
        data: (notifications) => ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Column(
              children: [
                ListTile(
                  title: Text(notification.title),
                  subtitle: Text(notification.message),
                ),
                const Divider(),
              ],
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => NetworkErrorView(
          onRetry: () {
            ref
                .read(notificationViewModelProvider.notifier)
                .fetchNotifications();
          },
        ),
      ),
    );
  }
}
