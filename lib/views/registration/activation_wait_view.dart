import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/views/navigation_root/navigation_root.dart';
import 'package:uni_links/uni_links.dart';

class ActivationWaitView extends ConsumerStatefulWidget {
  final String email;
  final String password;

  const ActivationWaitView(
      {super.key, required this.email, required this.password});

  @override
  ConsumerState createState() => _ActivationWaitViewState();
}

class _ActivationWaitViewState extends ConsumerState<ActivationWaitView> {
  bool isLoading = true;
  String accessToken = '';
  String refreshToken = '';

  @override
  void initState() {
    super.initState();
    bool isLogin = false;
    initUniLinks(ref);
    Future(() async {
      ref
          .watch(userDataProvider.notifier)
          .setMailAndPW(widget.email, widget.password);
      while (!isLogin) {
        isLogin =
            await ref.watch(userDataProvider.notifier).login(context: context);
        await Future.delayed(const Duration(seconds: 3));
        if (isLogin) {
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationRoot(),
            ),
            (_) => false,
          );
        }
      }
    });
  }

  Map<String, String>? getQueryParameter(String? link) {
    if (link == null) return null;
    final uri = Uri.parse(link);
    String? id = uri.queryParameters['id'];
    String? token = uri.queryParameters['token'];
    debugPrint('[from DeepLink] id:$id token:$token');
    if (id == null || token == null) return null;
    return {'id': id, 'token': token};
  }

  Future<void> initUniLinks(WidgetRef ref) async {
    linkStream.listen((String? link) {
      //設定したスキームをキャッチしてここが走る。
      final parameter = getQueryParameter(link);
      if (parameter != null) {
        ref.watch(userDataProvider.notifier).activation(parameter);
      }
      setState(() {});
    }, onError: (err) {
      debugPrint(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('メールを確認してアカウントを有効化してください'),
            const SizedBox(height: 16),
            if (isLoading) const CupertinoActivityIndicator(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
