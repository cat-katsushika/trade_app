// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'university_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

University _$UniversityFromJson(Map<String, dynamic> json) {
  return _University.fromJson(json);
}

/// @nodoc
mixin _$University {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UniversityCopyWith<University> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UniversityCopyWith<$Res> {
  factory $UniversityCopyWith(
          University value, $Res Function(University) then) =
      _$UniversityCopyWithImpl<$Res, University>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$UniversityCopyWithImpl<$Res, $Val extends University>
    implements $UniversityCopyWith<$Res> {
  _$UniversityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UniversityImplCopyWith<$Res>
    implements $UniversityCopyWith<$Res> {
  factory _$$UniversityImplCopyWith(
          _$UniversityImpl value, $Res Function(_$UniversityImpl) then) =
      __$$UniversityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$UniversityImplCopyWithImpl<$Res>
    extends _$UniversityCopyWithImpl<$Res, _$UniversityImpl>
    implements _$$UniversityImplCopyWith<$Res> {
  __$$UniversityImplCopyWithImpl(
      _$UniversityImpl _value, $Res Function(_$UniversityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$UniversityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UniversityImpl implements _University {
  const _$UniversityImpl({this.id = "", this.name = ""});

  factory _$UniversityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UniversityImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'University(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UniversityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UniversityImplCopyWith<_$UniversityImpl> get copyWith =>
      __$$UniversityImplCopyWithImpl<_$UniversityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UniversityImplToJson(
      this,
    );
  }
}

abstract class _University implements University {
  const factory _University({final String id, final String name}) =
      _$UniversityImpl;

  factory _University.fromJson(Map<String, dynamic> json) =
      _$UniversityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$UniversityImplCopyWith<_$UniversityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
