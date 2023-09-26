import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

main() {
  fetchWithCookies();
}

Future<void> fetchWithCookies() async {
  final dio = Dio();

  // CookieJarを設定
  final cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));

  // access_tokenとrefresh_tokenをクッキーに設定
  final uri = Uri.parse('http://127.0.0.1:8000/api/auth/users/me/');
  cookieJar.saveFromResponse(
    uri,
    [
      Cookie('access_token', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjk1NDU2NjM5LCJpYXQiOjE2OTU0NTMwMzksImp0aSI6IjVjODRhOTE1NjU5MDRiOGY5ZTdlMDUzMzQ0ZWZiZDEwIiwidXNlcl9pZCI6IjZiNDBjMmQyLTgyZjItNDRlNy1hNmZiLTVlMzZlZDU5ODljYiJ9.ZMJUhmxPyi0JKLsakRWM5mAXCU91vyLclACtnE6fwZ4'),
      Cookie('refresh_token', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY5NTcxMjIzOSwiaWF0IjoxNjk1NDUzMDM5LCJqdGkiOiJmMjBlOTU1MDMzODg0ZjE5OGMzNDQyNDliNDEyYjFiOCIsInVzZXJfaWQiOiI2YjQwYzJkMi04MmYyLTQ0ZTctYTZmYi01ZTM2ZWQ1OTg5Y2IifQ.LsBG4c9mllVmSr3qrAvIJgOYN_oCVOf_hJrdEjskw20'),
    ],
  );
  print(Cookie('access_token', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjk1NDU1NTQ1LCJpYXQiOjE2OTU0NTE5NDUsImp0aSI6IjdmM2VlMWUzNWZiYjQ3ZDg5M2QzZjI3OThmMWI3NjQxIiwidXNlcl9pZCI6IjZiNDBjMmQyLTgyZjItNDRlNy1hNmZiLTVlMzZlZDU5ODljYiJ9.1Y6BFZgqjjsWTDUt8TATEqAiYCBLBv0FZ7h8RLgAA_g'),);

  try {
    final response = await dio.get('http://127.0.0.1:8000/api/auth/users/me/');
    print(response.data);
  } catch (e) {
    print(e);
  }
}
