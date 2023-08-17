// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Photo _$$_PhotoFromJson(Map<String, dynamic> json) => _$_Photo(
      id: json['id'] as String? ?? "",
      parentItem: json['parentItem'] as String? ?? "",
      photo: json['photo'] as String? ?? "",
      uploadedAt: json['uploadedAt'] == null
          ? null
          : DateTime.parse(json['uploadedAt'] as String),
    );

Map<String, dynamic> _$$_PhotoToJson(_$_Photo instance) => <String, dynamic>{
      'id': instance.id,
      'parentItem': instance.parentItem,
      'photo': instance.photo,
      'uploadedAt': instance.uploadedAt?.toIso8601String(),
    };
