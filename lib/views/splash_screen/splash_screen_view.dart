import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/views/navigation_root/navigation_root.dart';
import 'package:trade_app/views/start/start_view.dart';

class SplashScreenView extends ConsumerStatefulWidget {
  const SplashScreenView({super.key});

  @override
  ConsumerState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends ConsumerState<SplashScreenView> {


  @override
  void initState() {
    //画面描画後に処理をコールバックで実行するもの
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.watch(userDataProvider.notifier).navigateWithUserData(context);
      Future(() {
        if (ref.read(userDataProvider).isLogin) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationRoot(),
            ),
                (_) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const StartView(),
            ),
                (_) => false,
          );
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
