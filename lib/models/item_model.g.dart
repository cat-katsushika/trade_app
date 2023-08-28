// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      imageSet: (json['imageSet'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      id: json['id'] as String? ?? "",
      listingStatus: json['listingStatus'] as String? ?? "",
      price: json['price'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      condition: json['condition'] as String? ?? "",
      writingState: json['writingState'] as String? ?? "",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      seller: json['seller'] as String? ?? "",
      buyer: json['buyer'] as String? ?? "",
      receivableCampus: json['receivableCampus'] as String? ?? "",
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'imageSet': instance.imageSet,
      'id': instance.id,
      'listingStatus': instance.listingStatus,
      'price': instance.price,
      'name': instance.name,
      'description': instance.description,
      'condition': instance.condition,
      'writingState': instance.writingState,
      'createdAt': instance.createdAt?.toIso8601String(),
      'seller': instance.seller,
      'buyer': instance.buyer,
      'receivableCampus': instance.receivableCampus,
    };
