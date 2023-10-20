import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trade_app/models/photo_model.dart';

part 'item_model.freezed.dart';

part 'item_model.g.dart';

@freezed
class Item with _$Item {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Item({
    @Default("") String id,
    @Default("") String seller,
    @Default("") String receivableCampus,
    @Default("") String image1,
    @Default("") String image2,
    @Default("") String image3,
    @Default("") String image4,
    @Default(false) bool isLikedByCurrentUser,
    @Default("") String listingStatus,
    @Default(0) int price,
    @Default("") String name,
    @Default("") String description,
    @Default("") String condition,
    @Default("") String writingState,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default("") String buyer,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
