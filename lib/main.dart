import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/views/NavigationRoot/navigation_root.dart';
import 'package:trade_app/views/login/login_view.dart';
import 'package:trade_app/views/registration/registration_view.dart';
import 'package:trade_app/views/start/start_view.dart';

void main() {
  runApp(const ProviderScope(child: TradeApp()));
}
class TradeApp extends StatelessWidget {
  const TradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primary),
        useMaterial3: true,
        scaffoldBackgroundColor: MyColors.ghostWhiteColor
      ),
      home: const StartView(),
    );
  }
}
