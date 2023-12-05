import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/config/user_data_provider.dart';
import 'package:trade_app/firebase_options.dart';
import 'package:trade_app/views/error/network_error_view.dart';
import 'package:trade_app/views/navigation_root/navigation_root.dart';
import 'package:trade_app/views/start/start_view.dart';

class SplashScreenView extends ConsumerStatefulWidget {
  const SplashScreenView({super.key});

  @override
  ConsumerState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends ConsumerState<SplashScreenView> {
  bool initStatus = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) setUp();
      },
    );
    super.initState();
  }

  void setUp() async {
    final isLogin =
        await ref.watch(userDataProvider.notifier).loginWithUserData(context);
    if (await firebaseSetup()) {
      navigation(isLogin);
    }
  }

  Future<bool> firebaseSetup() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // FCM の通知権限リクエスト
      final messaging = FirebaseMessaging.instance;
      final response = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      final token = await messaging.getToken();
      debugPrint('🐯 FCM TOKEN: $token');
      debugPrint("AuthStatus:${response.authorizationStatus}");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> navigation(bool isLogin) async {
    Future(() {
      if (isLogin) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigationRoot(),
          ),
          (_) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const StartView(),
          ),
          (_) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initStatus
          ? const CupertinoActivityIndicator()
          : NetworkErrorView(onRetry: setUp),
    );
  }
}
