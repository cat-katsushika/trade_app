import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/config/user_preferences.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/views/NavigationRoot/navigation_root.dart';

class LoginView extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDataNotifier = ref.watch(userDataProvider.notifier);
    var userDataState = ref.read(userDataProvider);
    return Scaffold(
      backgroundColor: MyColors.ghostWhiteColor,
      appBar: AppBar(backgroundColor: MyColors.ghostWhiteColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: Texts.emailHintText,
                hintText: Texts.emailHintText,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: Texts.passwordHintText,
                hintText: Texts.passwordHintText,
              ),
              obscureText: true,
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.tertiary,
                  foregroundColor: MyColors.white,
                ),
                onPressed: () async {
                  userDataNotifier.setMailAndPW(
                    _emailController.text,
                    _passwordController.text,
                  );
                  final isLogin = await userDataNotifier.login(
                    context: context,
                    errMsg: 'エラー 再度ログインしてください。',
                  );
                  userDataState = ref.read(userDataProvider);
                  if (isLogin) {
                    // ユーザーデータをShared Preferencesに保存
                    UserPreferences.saveUserData(
                      id: userDataState.id,
                      email: userDataState.email,
                      password: userDataState.password,
                    );
                  }
                  Future(() {
                    if (isLogin) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigationRoot(),
                        ),
                        (_) => false,
                      );
                    }
                  });
                },
                child: const Text(Texts.login),
              ),
            ),
            const SizedBox(height: 16),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
