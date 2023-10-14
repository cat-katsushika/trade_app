// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      message: json['message'] as String? ?? '',
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
      itemId: json['item_id'] as String? ?? '',
      user: json['user'] as String? ?? '',
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'message': instance.message,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'item_id': instance.itemId,
      'user': instance.user,
    };
