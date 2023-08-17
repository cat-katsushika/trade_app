import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trade_app/models/photo_model.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class Item with _$Item {
   @JsonSerializable(fieldRename: FieldRename.snake)
   const factory Item({
      @Default("") String id,
      @Default("") String sellerId,
      @Default("") String buyerId,
      @Default(false) bool isSold, // Default to false
      @Default("") String listingStatus,
      @Default(0) int price, // Default to 0
      @Default("") String name,
      @Default("") String description,
      @Default([]) List<Photo> photo, // Default to empty list
      @Default("") String condition,
      @Default("") String writingState,
      @Default(false) bool isExitCover, // Default to false
      @Default("") String receivableCampus,
      DateTime? createdAt,
   }) = _Item;

   factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
