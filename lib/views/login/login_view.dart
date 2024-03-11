import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/button_component.dart';
import 'package:trade_app/component/custom_text_form_field.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/config/user_preferences.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ログイン',
          style: TextStyle(color: MyColors.black),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.ghostWhiteColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AutofillGroup(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      Texts.emailLabelText,
                      style: MyTextStyles.mediumNormal.copyWith(
                        color: MyColors.black,
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    hasObscureIcon: false,
                    controller: _emailController,
                    hintText: Texts.emailHintText,
                    isObscure: false,
                    onToggleObscure: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      Texts.passwordLabelText,
                      style: MyTextStyles.mediumNormal.copyWith(
                        color: MyColors.black,
                      ),
                    ),
                  ),
                  CustomTextFormField(
                    hasObscureIcon: true,
                    controller: _passwordController,
                    hintText: Texts.passwordHintText,
                    isObscure: _isObscure,
                    onToggleObscure: (value) {
                      setState(() {
                        _isObscure = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const Spacer(),
                  ButtonComponent(
                    height: 50,
                    buttonColor: MyColors.secondary,
                    onPressed: () async {
                      _formKey.currentState!.validate();
                      ref.watch(userDataProvider.notifier).setMailAndPW(
                            _emailController.text,
                            _passwordController.text,
                          );
                      final isLogin =
                          await ref.watch(userDataProvider.notifier).login(
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
                    buttonText: Texts.login,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
