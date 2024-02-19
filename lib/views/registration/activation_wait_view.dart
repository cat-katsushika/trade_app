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
  String? id;
  String? token;

  @override
  void initState() {
    super.initState();
    initUniLinks();
    Future(() async {
      ref
          .watch(userDataProvider.notifier)
          .setMailAndPW(widget.email, widget.password);
    });
  }

  Map<String, String>? getQueryParameter(String? link) {
    if (link == null) return null;
    final uri = Uri.parse(link);
    id = uri.queryParameters['uid'];
    token = uri.queryParameters['token'];
    debugPrint('[from DeepLink] uid:$id token:$token');
    if (id == null || token == null) return null;
    return {'uid': id!, 'token': token!};
  }

  Future<void> initUniLinks() async {
    linkStream.listen((String? link) async {
      bool isLogin = false;
      final parameter = getQueryParameter(link);
      if (parameter != null) {
        ref.watch(userDataProvider.notifier).activation(parameter);
        while (!isLogin && mounted) {
          final loginSuccess = await ref.read(userDataProvider.notifier).login();
          if (loginSuccess) {
            isLogin = true;
            break; // ログイン成功時にループから抜けます。
          }

          // ログインが成功しない場合は数秒待ちます。
          await Future.delayed(const Duration(seconds: 3));

          if (!mounted) return;
        }

        if (isLogin && mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NavigationRoot()),
                (_) => false,
          );
        }
      }
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
