import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/app_bar_module.dart';
import 'package:trade_app/config/user_preferences.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
import 'package:trade_app/constant/settings.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/views/item_detail/setting_item_component.dart';
import 'package:trade_app/views/start/my_data_provider.dart';

class SettingView extends ConsumerStatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingViewState();
}

class _SettingViewState extends ConsumerState {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myData = ref.read(myDataProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.ghostWhiteColor,
        title: const Text(
          Texts.setting,
          style: TextStyle(color: MyColors.primary),
        ),
      ),
      body: Column(
        children: [
          // SettingsItemComponent(
          //   title: Texts.studentNumberHintText,
          //   trailing: Text(
          //     _retrievedStudentNumber,
          //   ),
          // ),
          SettingsItemComponent(
            title: Texts.emailHintText,
            trailing: Text(
              myData.email,
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
                  builder: (context) => Theme(
                    data: Theme.of(context).copyWith(
                      cardColor: MyColors.ghostWhiteColor,
                    ),
                    child: const LicensePage(
                      applicationName: Settings.appName,
                      applicationVersion: Settings.appVersion,
                    ),
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
    );
  }
}
