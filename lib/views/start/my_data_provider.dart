import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class MyData {
  const MyData({required this.id, required this.email, required this.campuses});

  final String id;
  final String email;
  final List<String> campuses;

  MyData copyWith({String? id, String? email, List<String>? campuses}) {
    return MyData(
      id: id ?? this.id,
      email: email ?? this.email,
      campuses: campuses ?? this.campuses,
    );
  }
}

class MyDataNotifier extends StateNotifier<MyData> {
  MyDataNotifier()
      : super(const MyData(
          id: '12345',
          email: 'example.ed.tus.ac.jp',
          campuses: [
            'Campus A',
            'Campus B',
          ],
        ));

  // データを取得する非同期関数
  // Future<void> fetchMyData() async {
  //   //TODO:通信
  //   state = const MyData(
  //     id: '12345',
  //     email: 'example.ed.tus.ac.jp',
  //     campuses: [
  //       'Campus 1',
  //       'Campus 2',
  //       'Campus 3',
  //     ],
  //   );
  // }

  void addMyData(MyData myData) {
    state = myData;
  }
}

final myDataProvider = StateNotifierProvider<MyDataNotifier, MyData>((ref) {
  return MyDataNotifier();
});
