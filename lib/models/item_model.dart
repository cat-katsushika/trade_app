import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trade_app/models/photo_model.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class Item with _$Item {
@JsonSerializable(fieldRename: FieldRename.snake)
  const factory Item({
    @Default([Photo(order: 1, photoPath: "")]) List<Photo> images,
    @Default("") String id,
    @Default("") String listingStatus,
    @Default(0) int price,
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
