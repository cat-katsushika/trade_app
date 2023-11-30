import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/config/user_preferences.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/views/navigation_root/navigation_root.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.ghostWhiteColor,
      appBar: AppBar(backgroundColor: MyColors.ghostWhiteColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AutofillGroup(
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
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: Texts.passwordHintText,
                  hintText: Texts.passwordHintText,
                  suffixIcon: IconButton(
                    icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isObscure,
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
                    ref.watch(userDataProvider.notifier).setMailAndPW(
                      _emailController.text,
                      _passwordController.text,
                    );
                    final isLogin = await ref.watch(userDataProvider.notifier).login(
                      context: context,
                      errMsg: 'エラー 再度ログインしてください。',
                    );
                    final userDataState = ref.read(userDataProvider);
                    if (isLogin) {
                      // ユーザーデータをShared Preferencesに保存
                      UserPreferences.saveUserData(
                        id: userDataState.id,
                        email: userDataState.email,
                        password: userDataState.password,
                      );
                      Future(() {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavigationRoot(),
                          ),
                              (_) => false,
                        );
                      });
                    }
                  },
                  child: const Text(Texts.login),
                ),
              ),
              const SizedBox(height: 16),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
