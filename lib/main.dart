import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/views/splash_screen/splash_screen_view.dart';

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
          appBarTheme: const AppBarTheme(
            surfaceTintColor: MyColors.white,
            color: MyColors.white,
            titleTextStyle: TextStyle(
              color: MyColors.light3,
              fontSize: 24,
            ),
          ),
          tabBarTheme: const TabBarTheme(unselectedLabelColor: MyColors.grey),
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primary),
          useMaterial3: true,
          scaffoldBackgroundColor: MyColors.ghostWhiteColor,
          primaryColor: MyColors.secondary,
          inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.grey, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyColors.secondary, width: 1.5),
              ),
              labelStyle: TextStyle(color: MyColors.grey, fontSize: 16)),
        ),
        home: home,
      ),
    );
  }
}
