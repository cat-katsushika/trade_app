import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trade_app/models/date_time_converter.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
class Comment with _$Comment {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Comment({
    @Default('') String comment,
    @DateTimeConverter()
    required DateTime createdAt,
    @Default('') String itemId,
    @Default('') String user,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
