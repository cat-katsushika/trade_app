import 'package:flutter/material.dart';

class NetworkErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const NetworkErrorView({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.wifi_off, // ネットワークエラーを示すアイコン
            size: 80.0,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          const Text(
            'ネットワーク接続がありません',
            style: TextStyle(fontSize: 18.0, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry, // ボタンが押された時にコールバック関数を実行
            child: const Text('再試行'),
          ),
        ],
      ),
    );
  }
}
