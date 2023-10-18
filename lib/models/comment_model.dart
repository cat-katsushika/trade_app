// // import 'package:freezed_annotation/freezed_annotation.dart';
// // import 'package:trade_app/models/date_time_converter.dart';
// //
// // part 'comment_model.freezed.dart';
// // part 'comment_model.g.dart';
// //
// // @freezed
// // class Comment with _$Comment {
// //   @JsonSerializable(fieldRename: FieldRename.snake)
// //   factory Comment({
// //     @Default('') String comment,
// //     @DateTimeConverter()
// //     required DateTime createdAt,
// //     @Default('') String itemId,
// //     @Default('') String user,
// //     @Default('') String userId,
// //     @Default('') String userEmail,
// //   }) = _Comment;
// //
// //   factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
// // }
//
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:trade_app/models/date_time_converter.dart';
//
// part 'comment_model.freezed.dart';
//
// @freezed
// class Comment with _$Comment {
//   factory Comment({
//     @Default('') String message,
//     @DateTimeConverter() required DateTime createdAt,
//     @Default('') String itemId,
//     @Default('') String user,
//     @Default('') String userId,
//     @Default('') String userEmail,
//   }) = _Comment;
//
//   factory Comment.fromJsonWithKeys(Map<String, dynamic> json,
//       {required String comOrMsg}) {
//     return Comment(
//       message: json[comOrMsg] as String,
//       createdAt: DateTime.parse(json['property_2'] as String),
//       itemId: json['item_id'] as String,
//       user: json['user'] as String,
//       userId: json['user_id'] as String,
//       userEmail: json['user_email'] as String,
//     );
//   }
//
//   toJsonWithKey({required String comOrMsg}) {
//     return {
//       comOrMsg: message,
//       'property_2': createdAt.toIso8601String(),
//       'item_id': itemId,
//       'user': user,
//       'user_id': userId,
//       'user_email': userEmail,
//     };
//   }
// }
