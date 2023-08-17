// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      id: json['id'] as String? ?? "",
      sellerId: json['seller_id'] as String? ?? "",
      buyerId: json['buyer_id'] as String? ?? "",
      isSold: json['is_sold'] as bool? ?? false,
      listingStatus: json['listing_status'] as String? ?? "",
      price: json['price'] as int? ?? 0,
      name: json['name'] as String? ?? "",
      description: json['description'] as String? ?? "",
      photo: (json['photo'] as List<dynamic>?)
              ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      condition: json['condition'] as String? ?? "",
      writingState: json['writing_state'] as String? ?? "",
      isExitCover: json['is_exit_cover'] as bool? ?? false,
      receivableCampus: json['receivable_campus'] as String? ?? "",
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'id': instance.id,
      'seller_id': instance.sellerId,
      'buyer_id': instance.buyerId,
      'is_sold': instance.isSold,
      'listing_status': instance.listingStatus,
      'price': instance.price,
      'name': instance.name,
      'description': instance.description,
      'photo': instance.photo,
      'condition': instance.condition,
      'writing_state': instance.writingState,
      'is_exit_cover': instance.isExitCover,
      'receivable_campus': instance.receivableCampus,
      'created_at': instance.createdAt?.toIso8601String(),
    };
