import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_item_model.freezed.dart';

@freezed
abstract class PostItem with _$PostItem {
  const factory PostItem({
    @Default("") String receivableCampus,
    required List<File> images,
    @Default("unpurchased") String listingStatus,
    @Default(0) int price,
    @Default("") String name,
    @Default("") String description,
    @Default("brand_new") String condition,
    @Default("none") String writingState,
    @Default("") String buyer,
    @Default("") String seller,
  }) = _PostItem;
}

@freezed
abstract class ImageSet with _$ImageSet {
  const factory ImageSet({
    required File photo,
    @Default("") String parentItem,
  }) = _ImageSet;
}
