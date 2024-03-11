import 'package:flutter/material.dart';
import 'package:trade_app/component/button_component.dart';
import 'package:trade_app/constant/image_path.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/views/login/login_view.dart';
import 'package:trade_app/views/registration/registration_view.dart';

class StartView extends StatefulWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            const Expanded(
              flex: 2,
              child: Image(
                image: AssetImage(ImagePath.appIconText),
              ),
            ),
            const Spacer(flex: 1),
            ButtonComponent(
              height: 50,
              buttonColor: MyColors.secondary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ),
                );
              },
              buttonText: 'ログイン',
            ),

            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("or"),
                ),
                Expanded(child: Divider()),
              ],
            ),
            ButtonComponent(
              height: 50,
              buttonColor: MyColors.primary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationView(),
                  ),
                );
              },
              buttonText: '登録',
            ),
            const SizedBox(height: 32),
            // Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
