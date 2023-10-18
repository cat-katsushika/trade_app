import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trade_app/models/date_time_converter.dart';

part 'message_model.freezed.dart';

part 'message_model.g.dart';

@freezed
class Message with _$Message {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Message({
    @Default('') String message,
    @DateTimeConverter() required DateTime createdAt,
    @Default('') String itemId,
    @Default('') String user,
    @Default('') String userId,
    @Default('') String userEmail,
  }) = _Message;

factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
