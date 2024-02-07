import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/component/circle_number_component.dart';
import 'package:trade_app/component/custom_text_form_field.dart';
import 'package:trade_app/component/horizontal_line.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/my_text_style.dart';
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
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  final _formKey = GlobalKey<FormState>();

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
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.ghostWhiteColor,
      appBar: AppBar(backgroundColor: MyColors.ghostWhiteColor),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '会員登録のステップ',
                  style: MyTextStyles.shortBold,
                ),
                const SizedBox(height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleNumberComponent(
                      number: 1,
                      text: '設定',
                      isBlack: true,
                    ),
                    HorizontalLine(),
                    CircleNumberComponent(
                      number: 2,
                      text: '送信',
                      isBlack: false,
                    ),
                    HorizontalLine(),
                    CircleNumberComponent(
                      number: 3,
                      text: '完了',
                      isBlack: false,
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                const Text(
                  '会員登録をする',
                  style: MyTextStyles.largeBold,
                ),
                const Text(
                  'メールアドレスとパスワードを設定してください。設定したメールアドレス宛に確認メールが届きます。「認証メールを送る」ボタンを押してください。',
                  style: MyTextStyles.mediumNormal,
                ),
                const SizedBox(height: 32),
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
                      return Texts.emailValidationMessage;
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
                  isObscure: _isObscure1,
                  onToggleObscure: (value) {
                    setState(() {
                      _isObscure1 = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Texts.passwordValidationMessage;
                    }
                    return null;
                  },
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
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
                  controller: _rePasswordController,
                  hintText: Texts.rePasswordHintText,
                  isObscure: _isObscure2,
                  onToggleObscure: (value) {
                    setState(() {
                      _isObscure2 = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Texts.rePasswordValidationMessage;
                    }
                    return null;
                  },
                  autofillHints: const [AutofillHints.password],
                  keyboardType: TextInputType.visiblePassword,
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
                            text: 'に同意する',
                            style: TextStyle(color: Colors.black))
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
                            text: 'に同意する',
                            style: TextStyle(color: Colors.black))
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
                            if (!isTermsChecked || !isPolicyChecked) {
                              _formKey.currentState!.validate();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('同意をお願いします'),
                                ),
                              );
                            } else {
                              handleButtonPress(viewModel);
                            }
                          },
                    child: const Text(Texts.sendEmail),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
