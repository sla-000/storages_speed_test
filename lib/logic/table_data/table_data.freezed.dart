// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'table_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MeasurementDto {
  Duration get fill => throw _privateConstructorUsedError;
  Duration get search => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MeasurementDtoCopyWith<MeasurementDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeasurementDtoCopyWith<$Res> {
  factory $MeasurementDtoCopyWith(
          MeasurementDto value, $Res Function(MeasurementDto) then) =
      _$MeasurementDtoCopyWithImpl<$Res>;
  $Res call({Duration fill, Duration search, int size});
}

/// @nodoc
class _$MeasurementDtoCopyWithImpl<$Res>
    implements $MeasurementDtoCopyWith<$Res> {
  _$MeasurementDtoCopyWithImpl(this._value, this._then);

  final MeasurementDto _value;
  // ignore: unused_field
  final $Res Function(MeasurementDto) _then;

  @override
  $Res call({
    Object? fill = freezed,
    Object? search = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      fill: fill == freezed
          ? _value.fill
          : fill // ignore: cast_nullable_to_non_nullable
              as Duration,
      search: search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as Duration,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_MeasurementDtoCopyWith<$Res>
    implements $MeasurementDtoCopyWith<$Res> {
  factory _$$_MeasurementDtoCopyWith(
          _$_MeasurementDto value, $Res Function(_$_MeasurementDto) then) =
      __$$_MeasurementDtoCopyWithImpl<$Res>;
  @override
  $Res call({Duration fill, Duration search, int size});
}

/// @nodoc
class __$$_MeasurementDtoCopyWithImpl<$Res>
    extends _$MeasurementDtoCopyWithImpl<$Res>
    implements _$$_MeasurementDtoCopyWith<$Res> {
  __$$_MeasurementDtoCopyWithImpl(
      _$_MeasurementDto _value, $Res Function(_$_MeasurementDto) _then)
      : super(_value, (v) => _then(v as _$_MeasurementDto));

  @override
  _$_MeasurementDto get _value => super._value as _$_MeasurementDto;

  @override
  $Res call({
    Object? fill = freezed,
    Object? search = freezed,
    Object? size = freezed,
  }) {
    return _then(_$_MeasurementDto(
      fill: fill == freezed
          ? _value.fill
          : fill // ignore: cast_nullable_to_non_nullable
              as Duration,
      search: search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as Duration,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_MeasurementDto implements _MeasurementDto {
  const _$_MeasurementDto(
      {required this.fill, required this.search, required this.size});

  @override
  final Duration fill;
  @override
  final Duration search;
  @override
  final int size;

  @override
  String toString() {
    return 'MeasurementDto(fill: $fill, search: $search, size: $size)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MeasurementDto &&
            const DeepCollectionEquality().equals(other.fill, fill) &&
            const DeepCollectionEquality().equals(other.search, search) &&
            const DeepCollectionEquality().equals(other.size, size));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fill),
      const DeepCollectionEquality().hash(search),
      const DeepCollectionEquality().hash(size));

  @JsonKey(ignore: true)
  @override
  _$$_MeasurementDtoCopyWith<_$_MeasurementDto> get copyWith =>
      __$$_MeasurementDtoCopyWithImpl<_$_MeasurementDto>(this, _$identity);
}

abstract class _MeasurementDto implements MeasurementDto {
  const factory _MeasurementDto(
      {required final Duration fill,
      required final Duration search,
      required final int size}) = _$_MeasurementDto;

  @override
  Duration get fill => throw _privateConstructorUsedError;
  @override
  Duration get search => throw _privateConstructorUsedError;
  @override
  int get size => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MeasurementDtoCopyWith<_$_MeasurementDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TableState {
  Map<StorageSwitch, List<MeasurementDto>> get data =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TableStateCopyWith<TableState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TableStateCopyWith<$Res> {
  factory $TableStateCopyWith(
          TableState value, $Res Function(TableState) then) =
      _$TableStateCopyWithImpl<$Res>;
  $Res call({Map<StorageSwitch, List<MeasurementDto>> data});
}

/// @nodoc
class _$TableStateCopyWithImpl<$Res> implements $TableStateCopyWith<$Res> {
  _$TableStateCopyWithImpl(this._value, this._then);

  final TableState _value;
  // ignore: unused_field
  final $Res Function(TableState) _then;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<StorageSwitch, List<MeasurementDto>>,
    ));
  }
}

/// @nodoc
abstract class _$$_TableStateCopyWith<$Res>
    implements $TableStateCopyWith<$Res> {
  factory _$$_TableStateCopyWith(
          _$_TableState value, $Res Function(_$_TableState) then) =
      __$$_TableStateCopyWithImpl<$Res>;
  @override
  $Res call({Map<StorageSwitch, List<MeasurementDto>> data});
}

/// @nodoc
class __$$_TableStateCopyWithImpl<$Res> extends _$TableStateCopyWithImpl<$Res>
    implements _$$_TableStateCopyWith<$Res> {
  __$$_TableStateCopyWithImpl(
      _$_TableState _value, $Res Function(_$_TableState) _then)
      : super(_value, (v) => _then(v as _$_TableState));

  @override
  _$_TableState get _value => super._value as _$_TableState;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_TableState(
      data: data == freezed
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<StorageSwitch, List<MeasurementDto>>,
    ));
  }
}

/// @nodoc

class _$_TableState implements _TableState {
  const _$_TableState(
      {final Map<StorageSwitch, List<MeasurementDto>> data =
          const <StorageSwitch, List<MeasurementDto>>{}})
      : _data = data;

  final Map<StorageSwitch, List<MeasurementDto>> _data;
  @override
  @JsonKey()
  Map<StorageSwitch, List<MeasurementDto>> get data {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'TableState(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TableState &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  _$$_TableStateCopyWith<_$_TableState> get copyWith =>
      __$$_TableStateCopyWithImpl<_$_TableState>(this, _$identity);
}

abstract class _TableState implements TableState {
  const factory _TableState(
      {final Map<StorageSwitch, List<MeasurementDto>> data}) = _$_TableState;

  @override
  Map<StorageSwitch, List<MeasurementDto>> get data =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TableStateCopyWith<_$_TableState> get copyWith =>
      throw _privateConstructorUsedError;
}
