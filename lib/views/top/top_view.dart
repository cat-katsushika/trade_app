import 'package:flutter/material.dart';
import 'package:trade_app/views/top/item_list_view.dart';

class TopView extends StatefulWidget {
  const TopView({Key? key}) : super(key: key);

  @override
  State<TopView> createState() => _TopViewState();
}

class _TopViewState extends State<TopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const ItemGridView(),
    );
  }
}
