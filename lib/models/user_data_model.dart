import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_model.freezed.dart';


//アプリの利用者に関するデータ
@freezed
abstract class UserData with _$UserData {
  const factory UserData({
    @Default('') String id,
    @Default('')  String email,
    @Default('')  String password,
    @Default('')  String accessToken,
    @Default('')  String refreshToken,
    @Default([])  List<String> campuses,
  }) = _UserData;
}
