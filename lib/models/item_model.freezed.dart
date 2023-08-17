// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  String get id => throw _privateConstructorUsedError;
  String get sellerId => throw _privateConstructorUsedError;
  String get buyerId => throw _privateConstructorUsedError;
  bool get isSold => throw _privateConstructorUsedError; // Default to false
  String get listingStatus => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError; // Default to 0
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<Photo> get photo =>
      throw _privateConstructorUsedError; // Default to empty list
  String get condition => throw _privateConstructorUsedError;
  String get writingState => throw _privateConstructorUsedError;
  bool get isExitCover =>
      throw _privateConstructorUsedError; // Default to false
  String get receivableCampus => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {String id,
      String sellerId,
      String buyerId,
      bool isSold,
      String listingStatus,
      int price,
      String name,
      String description,
      List<Photo> photo,
      String condition,
      String writingState,
      bool isExitCover,
      String receivableCampus,
      DateTime? createdAt});
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? buyerId = null,
    Object? isSold = null,
    Object? listingStatus = null,
    Object? price = null,
    Object? name = null,
    Object? description = null,
    Object? photo = null,
    Object? condition = null,
    Object? writingState = null,
    Object? isExitCover = null,
    Object? receivableCampus = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sellerId: null == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      buyerId: null == buyerId
          ? _value.buyerId
          : buyerId // ignore: cast_nullable_to_non_nullable
              as String,
      isSold: null == isSold
          ? _value.isSold
          : isSold // ignore: cast_nullable_to_non_nullable
              as bool,
      listingStatus: null == listingStatus
          ? _value.listingStatus
          : listingStatus // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photo: null == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as List<Photo>,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      writingState: null == writingState
          ? _value.writingState
          : writingState // ignore: cast_nullable_to_non_nullable
              as String,
      isExitCover: null == isExitCover
          ? _value.isExitCover
          : isExitCover // ignore: cast_nullable_to_non_nullable
              as bool,
      receivableCampus: null == receivableCampus
          ? _value.receivableCampus
          : receivableCampus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ItemCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$_ItemCopyWith(_$_Item value, $Res Function(_$_Item) then) =
      __$$_ItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sellerId,
      String buyerId,
      bool isSold,
      String listingStatus,
      int price,
      String name,
      String description,
      List<Photo> photo,
      String condition,
      String writingState,
      bool isExitCover,
      String receivableCampus,
      DateTime? createdAt});
}

/// @nodoc
class __$$_ItemCopyWithImpl<$Res> extends _$ItemCopyWithImpl<$Res, _$_Item>
    implements _$$_ItemCopyWith<$Res> {
  __$$_ItemCopyWithImpl(_$_Item _value, $Res Function(_$_Item) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? buyerId = null,
    Object? isSold = null,
    Object? listingStatus = null,
    Object? price = null,
    Object? name = null,
    Object? description = null,
    Object? photo = null,
    Object? condition = null,
    Object? writingState = null,
    Object? isExitCover = null,
    Object? receivableCampus = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$_Item(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sellerId: null == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      buyerId: null == buyerId
          ? _value.buyerId
          : buyerId // ignore: cast_nullable_to_non_nullable
              as String,
      isSold: null == isSold
          ? _value.isSold
          : isSold // ignore: cast_nullable_to_non_nullable
              as bool,
      listingStatus: null == listingStatus
          ? _value.listingStatus
          : listingStatus // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      photo: null == photo
          ? _value._photo
          : photo // ignore: cast_nullable_to_non_nullable
              as List<Photo>,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String,
      writingState: null == writingState
          ? _value.writingState
          : writingState // ignore: cast_nullable_to_non_nullable
              as String,
      isExitCover: null == isExitCover
          ? _value.isExitCover
          : isExitCover // ignore: cast_nullable_to_non_nullable
              as bool,
      receivableCampus: null == receivableCampus
          ? _value.receivableCampus
          : receivableCampus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Item implements _Item {
  const _$_Item(
      {this.id = "",
      this.sellerId = "",
      this.buyerId = "",
      this.isSold = false,
      this.listingStatus = "",
      this.price = 0,
      this.name = "",
      this.description = "",
      final List<Photo> photo = const [],
      this.condition = "",
      this.writingState = "",
      this.isExitCover = false,
      this.receivableCampus = "",
      this.createdAt})
      : _photo = photo;

  factory _$_Item.fromJson(Map<String, dynamic> json) => _$$_ItemFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String sellerId;
  @override
  @JsonKey()
  final String buyerId;
  @override
  @JsonKey()
  final bool isSold;
// Default to false
  @override
  @JsonKey()
  final String listingStatus;
  @override
  @JsonKey()
  final int price;
// Default to 0
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  final List<Photo> _photo;
  @override
  @JsonKey()
  List<Photo> get photo {
    if (_photo is EqualUnmodifiableListView) return _photo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photo);
  }

// Default to empty list
  @override
  @JsonKey()
  final String condition;
  @override
  @JsonKey()
  final String writingState;
  @override
  @JsonKey()
  final bool isExitCover;
// Default to false
  @override
  @JsonKey()
  final String receivableCampus;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Item(id: $id, sellerId: $sellerId, buyerId: $buyerId, isSold: $isSold, listingStatus: $listingStatus, price: $price, name: $name, description: $description, photo: $photo, condition: $condition, writingState: $writingState, isExitCover: $isExitCover, receivableCampus: $receivableCampus, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Item &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.buyerId, buyerId) || other.buyerId == buyerId) &&
            (identical(other.isSold, isSold) || other.isSold == isSold) &&
            (identical(other.listingStatus, listingStatus) ||
                other.listingStatus == listingStatus) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._photo, _photo) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.writingState, writingState) ||
                other.writingState == writingState) &&
            (identical(other.isExitCover, isExitCover) ||
                other.isExitCover == isExitCover) &&
            (identical(other.receivableCampus, receivableCampus) ||
                other.receivableCampus == receivableCampus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sellerId,
      buyerId,
      isSold,
      listingStatus,
      price,
      name,
      description,
      const DeepCollectionEquality().hash(_photo),
      condition,
      writingState,
      isExitCover,
      receivableCampus,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemCopyWith<_$_Item> get copyWith =>
      __$$_ItemCopyWithImpl<_$_Item>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemToJson(
      this,
    );
  }
}

abstract class _Item implements Item {
  const factory _Item(
      {final String id,
      final String sellerId,
      final String buyerId,
      final bool isSold,
      final String listingStatus,
      final int price,
      final String name,
      final String description,
      final List<Photo> photo,
      final String condition,
      final String writingState,
      final bool isExitCover,
      final String receivableCampus,
      final DateTime? createdAt}) = _$_Item;

  factory _Item.fromJson(Map<String, dynamic> json) = _$_Item.fromJson;

  @override
  String get id;
  @override
  String get sellerId;
  @override
  String get buyerId;
  @override
  bool get isSold;
  @override // Default to false
  String get listingStatus;
  @override
  int get price;
  @override // Default to 0
  String get name;
  @override
  String get description;
  @override
  List<Photo> get photo;
  @override // Default to empty list
  String get condition;
  @override
  String get writingState;
  @override
  bool get isExitCover;
  @override // Default to false
  String get receivableCampus;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_ItemCopyWith<_$_Item> get copyWith => throw _privateConstructorUsedError;
}
