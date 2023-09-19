import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/views/NavigationRoot/navigation_root.dart';

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
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return const NavigationRoot();
          //     },
          //   ),
          // );
        }
      }
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
            if (isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
