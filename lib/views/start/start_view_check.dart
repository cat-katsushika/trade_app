import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_app/views/start/my_data_provider.dart';
import 'package:trade_app/views/start/start_view.dart';

class StartViewCheck extends ConsumerStatefulWidget {
  const StartViewCheck({super.key});

  @override
  ConsumerState createState() => _TradeAppState();
}

class _TradeAppState extends ConsumerState<StartViewCheck> {

  Future<MyData> fetchMyData() async {
      await Future.delayed(const Duration(seconds: 1));
      return const MyData(
        id: '12345',
        email: 'example.ed.tus.ac.jp',
        campuses: [
          'Campus 1',
          'Campus 2',
          'Campus 3',
        ],
      );

  }

  @override
  Widget build(BuildContext context) {
    final myDataState = ref.read(myDataProvider);
    return FutureBuilder(
      future: fetchMyData(),
      builder: (BuildContext context, AsyncSnapshot<MyData> snapshot) {
        if (snapshot.hasData) {
          // myDataNotifier.addMyData(snapshot.data!);
          return const StartView();
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('error'),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
    // final myData = ref.read(myDataProvider);
    // if (myData.email == 'nothing') {
    //   return const Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // } else if (myData.email == 'error') {
    //   return const Scaffold(
    //     body: Center(
    //       child: Text('エラー'),
    //     ),
    //   );
    // } else {
    //   return const StartView();
    // }
  }
}
