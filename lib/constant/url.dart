import 'package:url_launcher/url_launcher.dart';

class Url{
  static const getItemList = "https://2f338ce1-8358-4109-a88b-929d6bbbcd07.mock.pstmn.io";
  static const webVerUrl = "https://www.google.com/";
  static const apiUrl = 'https://uni-bo.net/api/';

  static Future<void> launchWebVer() async {
    if (!await launchUrl(Uri.parse(webVerUrl))) {
      throw Exception('Could not launch $webVerUrl');
    }
  }
}