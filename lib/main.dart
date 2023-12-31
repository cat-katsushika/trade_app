import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/views/splash_screen/splash_screen_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(
    const TradeApp(
      home: Scaffold(
        body: Center(
          child: SplashScreenView(),
        ),
      ),
    ),
  );
}

class TradeApp extends StatelessWidget {
  const TradeApp({Key? key, required this.home}) : super(key: key);
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primary),
            useMaterial3: true,
            scaffoldBackgroundColor: MyColors.ghostWhiteColor),
        home: home,
      ),
    );
  }
}
