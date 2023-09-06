import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/views/start/start_view_check.dart';

void main() {
  runApp(const ProviderScope(child: TradeApp()));
}

class TradeApp extends StatefulWidget {
  const TradeApp({Key? key}) : super(key: key);

  @override
  State<TradeApp> createState() => _TradeAppState();
}

class _TradeAppState extends State<TradeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primary),
          useMaterial3: true,
          scaffoldBackgroundColor: MyColors.ghostWhiteColor),
      home: const Scaffold(
        body: Center(
          child: StartViewCheck(),
        ),
      ),
    );
  }
}
