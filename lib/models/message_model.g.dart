// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      message: json['message'] as String? ?? '',
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
      itemId: json['item_id'] as String? ?? '',
      user: json['user'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      userEmail: json['user_email'] as String? ?? '',
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'item_id': instance.itemId,
      'user': instance.user,
      'user_id': instance.userId,
      'user_email': instance.userEmail,
    };
