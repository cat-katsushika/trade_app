import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trade_app/models/photo_model.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

// @JsonSerializable(fieldRename: FieldRename.snake)
@freezed
class Item with _$Item {
  const factory Item({
    @Default([]) List<Photo> imageSet, // Default to empty list
    @Default("") String id,
    @Default("") String listingStatus,
    @Default(0) int price, // Default to 0
    @Default("") String name,
    @Default("") String description,
    @Default("") String condition,
    @Default("") String writingState,
    DateTime? createdAt,
    @Default("") String seller,
    @Default("") String buyer,
    @Default("") String receivableCampus,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
