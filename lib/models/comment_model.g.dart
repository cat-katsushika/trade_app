// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      comment: json['comment'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      itemId: json['itemId'] as String? ?? '',
      user: json['user'] as String? ?? '',
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'itemId': instance.itemId,
      'user': instance.user,
    };
