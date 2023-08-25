import 'package:freezed_annotation/freezed_annotation.dart';

part 'university_model.freezed.dart';
part 'university_model.g.dart';

@freezed
class University with _$University {
  const factory University({
    @Default("") String id,
    @Default("") String name,
  }) = _University;

  factory University.fromJson(Map<String, dynamic> json) => _$UniversityFromJson(json);
}
