// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [Photo(order: 1, photoPath: "")],
      id: json['id'] as String? ?? "",
      listingStatus: json['listing_status'] as String? ?? "",
      price: json['price'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      condition: json['condition'] as String? ?? "",
      writingState: json['writing_state'] as String? ?? "",
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      seller: json['seller'] as String? ?? "",
      buyer: json['buyer'] as String? ?? "",
      receivableCampus: json['receivable_campus'] as String? ?? "",
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'images': instance.images,
      'id': instance.id,
      'listing_status': instance.listingStatus,
      'price': instance.price,
      'name': instance.name,
      'description': instance.description,
      'condition': instance.condition,
      'writing_state': instance.writingState,
      'created_at': instance.createdAt?.toIso8601String(),
      'seller': instance.seller,
      'buyer': instance.buyer,
      'receivable_campus': instance.receivableCampus,
    };
