import 'package:flutter/material.dart';
import 'package:trade_app/views/setting/setting_view.dart';
import 'package:trade_app/views/top/top_view.dart';

class NavigationRoot extends StatefulWidget {
  const NavigationRoot({Key? key}) : super(key: key);

  @override
  State<NavigationRoot> createState() => _NavigationRootState();
}

class _NavigationRootState extends State<NavigationRoot> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const TopView(),
    const SettingView()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt((_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list),label: "フィード"),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: "設定"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
