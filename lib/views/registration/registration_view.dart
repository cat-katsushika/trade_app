import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/views/registration/activation_wait_view.dart';
import 'package:trade_app/views/registration/registration_view_model.dart';

class RegistrationView extends ConsumerStatefulWidget {
  const RegistrationView({super.key});

  @override
  ConsumerState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends ConsumerState<RegistrationView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  bool isButtonDisabled = false;
  bool isTermsChecked = false;
  bool isPolicyChecked = false;

  Future<void> handleButtonPress(RegistrationViewModel viewModel) async {
    setState(() => isButtonDisabled = true);
    var isRegistration = false;
    try {
      isRegistration = await viewModel.registration(
        email: _emailController.text,
        password: _passwordController.text,
        rePassword: _rePasswordController.text,
        snackFunction: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (isRegistration) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return ActivationWaitView(
                email: _emailController.text,
                password: _passwordController.text,
              );
            },
          ),
        );
      }
    }
    setState(() => isButtonDisabled = false);
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 16.0),
            TextField(
              controller: _rePasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: Texts.rePasswordHintText,
                hintText: Texts.rePasswordHintText,
              ),
              obscureText: true,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '利用規約',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Url.launch(Url.termsUrl);
                          }),
                    const TextSpan(
                        text: 'に同意する', style: TextStyle(color: Colors.black))
                  ]),
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Checkbox(
                    value: isTermsChecked,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => isTermsChecked = value);
                      }
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'プライバシーポリシー',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Url.launch(Url.policyUrl);
                          }),
                    const TextSpan(
                        text: 'に同意する', style: TextStyle(color: Colors.black))
                  ]),
                ),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Checkbox(
                    value: isPolicyChecked,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => isPolicyChecked = value);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  foregroundColor: MyColors.white,
                ),
                onPressed: (isButtonDisabled)
                    ? null
                    : () {
                        if (!isTermsChecked|| !isPolicyChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('同意をお願いします'),
                            ),
                          );
                        } else {
                          handleButtonPress(viewModel);
                        }
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
