import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/models/user_model.dart';
import 'package:trade_app/views/NavigationRoot/navigation_root.dart';
import 'package:trade_app/views/login/login_view_model.dart';
import 'package:trade_app/views/registration/registration_view.dart';

class LoginView extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(loginViewModelProvider);

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
                onPressed: () {
                  // ViewModelのログインメソッドを呼び出す
                  viewModel.login(
                    UserModel(
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );
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
