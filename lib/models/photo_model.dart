import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class Photo with _$Photo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Photo({
    @Default(0) int order,
    @Default("") String photoPath,
    // DateTime? uploadedAt,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
