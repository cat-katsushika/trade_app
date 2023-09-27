import 'package:flutter/material.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/views/exhibit/exhibit_view.dart';
import 'package:trade_app/views/my_page/my_page_view.dart';
import 'package:trade_app/views/setting/setting_view.dart';
import 'package:trade_app/views/top/top_view.dart';

class NavigationRoot extends StatefulWidget {
  const NavigationRoot({this.snackMessage, super.key});

  final String? snackMessage;

  @override
  State<NavigationRoot> createState() => _NavigationRootState();
}

class _NavigationRootState extends State<NavigationRoot> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      TopView(
        snackMessage: widget.snackMessage,
      ),
      const ExhibitView(),
      const MyPageView(),
      const SettingView()
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: widgetOptions,
      ),
      // body: Center(
      //   child: _widgetOptions.elementAt((_selectedIndex)),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: Texts.top),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera_outlined), label: Texts.exhibit),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: Texts.myPage),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: Texts.setting),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
