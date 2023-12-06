// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campus_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Campus _$CampusFromJson(Map<String, dynamic> json) {
  return _Campus.fromJson(json);
}

/// @nodoc
mixin _$Campus {
  String get id => throw _privateConstructorUsedError;
  String get campus => throw _privateConstructorUsedError;
  String get university => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CampusCopyWith<Campus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampusCopyWith<$Res> {
  factory $CampusCopyWith(Campus value, $Res Function(Campus) then) =
      _$CampusCopyWithImpl<$Res, Campus>;
  @useResult
  $Res call({String id, String campus, String university});
}

/// @nodoc
class _$CampusCopyWithImpl<$Res, $Val extends Campus>
    implements $CampusCopyWith<$Res> {
  _$CampusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campus = null,
    Object? university = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      campus: null == campus
          ? _value.campus
          : campus // ignore: cast_nullable_to_non_nullable
              as String,
      university: null == university
          ? _value.university
          : university // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CampusImplCopyWith<$Res> implements $CampusCopyWith<$Res> {
  factory _$$CampusImplCopyWith(
          _$CampusImpl value, $Res Function(_$CampusImpl) then) =
      __$$CampusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String campus, String university});
}

/// @nodoc
class __$$CampusImplCopyWithImpl<$Res>
    extends _$CampusCopyWithImpl<$Res, _$CampusImpl>
    implements _$$CampusImplCopyWith<$Res> {
  __$$CampusImplCopyWithImpl(
      _$CampusImpl _value, $Res Function(_$CampusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campus = null,
    Object? university = null,
  }) {
    return _then(_$CampusImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      campus: null == campus
          ? _value.campus
          : campus // ignore: cast_nullable_to_non_nullable
              as String,
      university: null == university
          ? _value.university
          : university // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CampusImpl implements _Campus {
  const _$CampusImpl(
      {required this.id, required this.campus, required this.university});

  factory _$CampusImpl.fromJson(Map<String, dynamic> json) =>
      _$$CampusImplFromJson(json);

  @override
  final String id;
  @override
  final String campus;
  @override
  final String university;

  @override
  String toString() {
    return 'Campus(id: $id, campus: $campus, university: $university)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampusImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.campus, campus) || other.campus == campus) &&
            (identical(other.university, university) ||
                other.university == university));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, campus, university);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CampusImplCopyWith<_$CampusImpl> get copyWith =>
      __$$CampusImplCopyWithImpl<_$CampusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CampusImplToJson(
      this,
    );
  }
}

abstract class _Campus implements Campus {
  const factory _Campus(
      {required final String id,
      required final String campus,
      required final String university}) = _$CampusImpl;

  factory _Campus.fromJson(Map<String, dynamic> json) = _$CampusImpl.fromJson;

  @override
  String get id;
  @override
  String get campus;
  @override
  String get university;
  @override
  @JsonKey(ignore: true)
  _$$CampusImplCopyWith<_$CampusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
