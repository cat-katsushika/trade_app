// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Photo _$$_PhotoFromJson(Map<String, dynamic> json) => _$_Photo(
      order: json['order'] as int? ?? 0,
      photoPath: json['photo_path'] as String? ?? "",
      uploadedAt: json['uploaded_at'] == null
          ? null
          : DateTime.parse(json['uploaded_at'] as String),
    );

Map<String, dynamic> _$$_PhotoToJson(_$_Photo instance) => <String, dynamic>{
      'order': instance.order,
      'photo_path': instance.photoPath,
      'uploaded_at': instance.uploadedAt?.toIso8601String(),
    };
