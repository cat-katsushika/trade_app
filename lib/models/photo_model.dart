import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    @Default("") String id,
    @Default("") String parentItem,
    @Default("") String photo,
    DateTime? uploadedAt,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
