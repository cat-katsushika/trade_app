import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trade_app/models/university_model.dart';

part 'campus_model.freezed.dart';
part 'campus_model.g.dart';

@freezed
class Campus with _$Campus {
  const factory Campus({
    required String id,
    required String campus,
    required String university,
  }) = _Campus;

  factory Campus.fromJson(Map<String, dynamic> json) => _$CampusFromJson(json);
}
