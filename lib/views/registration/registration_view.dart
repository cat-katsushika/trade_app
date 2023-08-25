import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/user_model.dart';
import 'package:trade_app/views/NavigationRoot/navigation_root.dart';
import 'package:trade_app/views/login/login_view.dart';
import 'package:trade_app/views/registration/registration_view_model.dart';

class RegistrationView extends ConsumerWidget {
  // テキストコントローラーの定義
  final _studentNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegistrationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModelのインスタンスを取得
    final viewModel = ref.read(registrationViewModelProvider);

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
                labelText: Texts.studentNumberHintText,
                hintText: Texts.studentNumberHintText,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
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
                  backgroundColor: MyColors.primary,
                  foregroundColor: MyColors.white,
                ),
                onPressed: () {
                  viewModel.registration(
                    UserModel(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );
                },
                child: const Text('登録'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
