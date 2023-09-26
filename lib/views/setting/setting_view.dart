import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/purchase_dialog.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/config/user_preferences.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/settings.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/views/item_detail/setting_item_component.dart';
import 'package:trade_app/views/start/start_view.dart';

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
    final myData = ref.read(userDataProvider);
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
            },
          ),
          SettingsItemComponent(
            onTap: () =>
              Url.launch(Url.termsUrl),
            title: '利用規約',
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: MyColors.primary,
              size: 12,
            ),
          ),
          SettingsItemComponent(
            onTap: () =>
              Url.launch(Url.policyUrl),
            title: 'プライバシーポリシー',
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: MyColors.primary,
              size: 12,
            ),
          ),
          SettingsItemComponent(
            title: 'ログアウト',
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: MyColors.primary,
              size: 12,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialogComponent(
                    alertMessage: 'ログアウトしますか？',
                    leftText: 'ログアウト',
                    rightText: 'キャンセル',
                    onTap: () async {
                      await UserPreferences.clearUserData();
                      Future(
                            () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const StartView()),
                              (_) => false,
                        ),
                      );
                    }
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
