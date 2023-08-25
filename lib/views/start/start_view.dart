import 'package:flutter/material.dart';
import 'package:trade_app/constant/my_colors.dart';
import 'package:trade_app/constant/texts.dart';
import 'package:trade_app/constant/url.dart';
import 'package:trade_app/views/NavigationRoot/navigation_root.dart';
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
            Expanded(flex:2,child: Container()),
            const Expanded(flex: 3,child: Image(image: AssetImage('assets/images/app_icon.png'))),
            Expanded(child: Container()),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.tertiary,
                  foregroundColor: MyColors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
                  debugPrint('ログインボタンが押されました');
                },
                child: const Text('ログイン'),
              ),
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
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  foregroundColor: MyColors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationView(),
                    ),
                  );
                  debugPrint('登録ボタンが押されました');
                },
                child: const Text('登録'),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Url.launchWebVer();
              },
              child: const Text(
                Texts.notLoginText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.tertiary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationRoot(),
            ),
          );
        },
      ),
    );
  }
}
