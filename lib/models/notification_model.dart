import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trade_app/models/date_time_converter.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory NotificationModel({
    @Default("") String id,
    @Default("") String title,
    @Default("") String message,
    @Default(false) bool? isRead,
    @DateTimeConverter() required DateTime? createdAt,
    @DateTimeConverter() required DateTime? updatedAt,
    String? user,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
