// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Campus _$$_CampusFromJson(Map<String, dynamic> json) => _$_Campus(
      id: json['id'] as String,
      campus: json['campus'] as String,
      university:
          University.fromJson(json['university'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CampusToJson(_$_Campus instance) => <String, dynamic>{
      'id': instance.id,
      'campus': instance.campus,
      'university': instance.university,
    };
