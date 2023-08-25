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
  University get university => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CampusCopyWith<Campus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampusCopyWith<$Res> {
  factory $CampusCopyWith(Campus value, $Res Function(Campus) then) =
      _$CampusCopyWithImpl<$Res, Campus>;
  @useResult
  $Res call({String id, String campus, University university});

  $UniversityCopyWith<$Res> get university;
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
              as University,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UniversityCopyWith<$Res> get university {
    return $UniversityCopyWith<$Res>(_value.university, (value) {
      return _then(_value.copyWith(university: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CampusCopyWith<$Res> implements $CampusCopyWith<$Res> {
  factory _$$_CampusCopyWith(_$_Campus value, $Res Function(_$_Campus) then) =
      __$$_CampusCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String campus, University university});

  @override
  $UniversityCopyWith<$Res> get university;
}

/// @nodoc
class __$$_CampusCopyWithImpl<$Res>
    extends _$CampusCopyWithImpl<$Res, _$_Campus>
    implements _$$_CampusCopyWith<$Res> {
  __$$_CampusCopyWithImpl(_$_Campus _value, $Res Function(_$_Campus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? campus = null,
    Object? university = null,
  }) {
    return _then(_$_Campus(
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
              as University,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Campus implements _Campus {
  const _$_Campus(
      {required this.id, required this.campus, required this.university});

  factory _$_Campus.fromJson(Map<String, dynamic> json) =>
      _$$_CampusFromJson(json);

  @override
  final String id;
  @override
  final String campus;
  @override
  final University university;

  @override
  String toString() {
    return 'Campus(id: $id, campus: $campus, university: $university)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Campus &&
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
  _$$_CampusCopyWith<_$_Campus> get copyWith =>
      __$$_CampusCopyWithImpl<_$_Campus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CampusToJson(
      this,
    );
  }
}

abstract class _Campus implements Campus {
  const factory _Campus(
      {required final String id,
      required final String campus,
      required final University university}) = _$_Campus;

  factory _Campus.fromJson(Map<String, dynamic> json) = _$_Campus.fromJson;

  @override
  String get id;
  @override
  String get campus;
  @override
  University get university;
  @override
  @JsonKey(ignore: true)
  _$$_CampusCopyWith<_$_Campus> get copyWith =>
      throw _privateConstructorUsedError;
}
