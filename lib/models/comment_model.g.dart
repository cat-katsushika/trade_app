// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      comment: json['comment'] as String? ?? '',
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
      itemId: json['item_id'] as String? ?? '',
      user: json['user'] as String? ?? '',
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'item_id': instance.itemId,
      'user': instance.user,
    };
