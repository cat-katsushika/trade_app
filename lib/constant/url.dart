import 'package:url_launcher/url_launcher.dart';

class Url{
  // static const getItemList = "https://2f338ce1-8358-4109-a88b-929d6bbbcd07.mock.pstmn.io";
  static const webVerUrl = "https://www.google.com/";
  static const termsUrl = "${host}terms-of-service/";
  static const policyUrl = "${host}privacy-policy/";

  static const host = 'https://www.uni-bo.net/';
  static const apiUrl = '${host}api/';
  static final  uriHost = Uri.parse(host);
  // static const apiUrl = 'http://127.0.0.1:8000/api/';
  // static final uriHost = Uri.parse('http://127.0.0.1:8000/');

  static const com = 'comment';
  static const msg = 'messages';

  static Future<void> launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}