import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/app_bar_module.dart';
import 'package:trade_app/config/user_preferences.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/constant/settings.dart';
import 'package:trade_app/views/item_detail/setting_item_component.dart';

class SettingView extends ConsumerStatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingViewState();
}

class _SettingViewState extends ConsumerState {
  String _retrievedStudentNumber = '';
  String _retrievedEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    final data = await UserPreferences.getUserData();
    setState(() {
      _retrievedStudentNumber = data['studentNumber']!;
      _retrievedEmail = data['email']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: MyColors.ghostWhiteColor,
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(
            color: MyColors.primary
          ),
        ),
      ),
      body: Column(
        children: [
          SettingsItemComponent(
            title: '学籍番号',
            trailing: Text(
              _retrievedStudentNumber,
            ),
          ),
          SettingsItemComponent(
            title: 'メールアドレス',
            trailing: Text(
              _retrievedEmail,
            ),
          ),
          SettingsItemComponent(
            title: 'ライセンス',
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: MyColors.primary,
              size: 12,
            ),
            onTap: () {
              Navigator.push<MaterialPageRoute<dynamic>>(
                context,
                MaterialPageRoute(
                  builder: (context) => const LicensePage(
                    applicationName: Settings.appName,
                    applicationVersion: Settings.appVersion,
                  ),
                ),
              );
              // pushNewScreen(
              //   context,
              //   screen: const LicensePage(
              //     applicationName: '',
              //     applicationVersion: '',
              //   ),
              // );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(await UserPreferences.getCampusList());
          await UserPreferences.saveCampusList(["キャンパス1", "キャンパス2", "キャンパス3"]);
          setState(() {
          });
        },
      ),
    );
  }
}
