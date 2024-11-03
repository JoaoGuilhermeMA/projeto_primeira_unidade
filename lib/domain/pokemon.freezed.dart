// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Pokemon _$PokemonFromJson(Map<String, dynamic> json) {
  return _Pokemon.fromJson(json);
}

/// @nodoc
mixin _$Pokemon {
  int get id => throw _privateConstructorUsedError;
  String get nameEnglish => throw _privateConstructorUsedError;
  String get nameJapanese => throw _privateConstructorUsedError;
  String get nameChinese => throw _privateConstructorUsedError;
  String get nameFrench => throw _privateConstructorUsedError;
  List<String> get type => throw _privateConstructorUsedError;
  Map<String, int> get baseStats => throw _privateConstructorUsedError;

  /// Serializes this Pokemon to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PokemonCopyWith<Pokemon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PokemonCopyWith<$Res> {
  factory $PokemonCopyWith(Pokemon value, $Res Function(Pokemon) then) =
      _$PokemonCopyWithImpl<$Res, Pokemon>;
  @useResult
  $Res call(
      {int id,
      String nameEnglish,
      String nameJapanese,
      String nameChinese,
      String nameFrench,
      List<String> type,
      Map<String, int> baseStats});
}

/// @nodoc
class _$PokemonCopyWithImpl<$Res, $Val extends Pokemon>
    implements $PokemonCopyWith<$Res> {
  _$PokemonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameEnglish = null,
    Object? nameJapanese = null,
    Object? nameChinese = null,
    Object? nameFrench = null,
    Object? type = null,
    Object? baseStats = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nameEnglish: null == nameEnglish
          ? _value.nameEnglish
          : nameEnglish // ignore: cast_nullable_to_non_nullable
              as String,
      nameJapanese: null == nameJapanese
          ? _value.nameJapanese
          : nameJapanese // ignore: cast_nullable_to_non_nullable
              as String,
      nameChinese: null == nameChinese
          ? _value.nameChinese
          : nameChinese // ignore: cast_nullable_to_non_nullable
              as String,
      nameFrench: null == nameFrench
          ? _value.nameFrench
          : nameFrench // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      baseStats: null == baseStats
          ? _value.baseStats
          : baseStats // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PokemonImplCopyWith<$Res> implements $PokemonCopyWith<$Res> {
  factory _$$PokemonImplCopyWith(
          _$PokemonImpl value, $Res Function(_$PokemonImpl) then) =
      __$$PokemonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String nameEnglish,
      String nameJapanese,
      String nameChinese,
      String nameFrench,
      List<String> type,
      Map<String, int> baseStats});
}

/// @nodoc
class __$$PokemonImplCopyWithImpl<$Res>
    extends _$PokemonCopyWithImpl<$Res, _$PokemonImpl>
    implements _$$PokemonImplCopyWith<$Res> {
  __$$PokemonImplCopyWithImpl(
      _$PokemonImpl _value, $Res Function(_$PokemonImpl) _then)
      : super(_value, _then);

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nameEnglish = null,
    Object? nameJapanese = null,
    Object? nameChinese = null,
    Object? nameFrench = null,
    Object? type = null,
    Object? baseStats = null,
  }) {
    return _then(_$PokemonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      nameEnglish: null == nameEnglish
          ? _value.nameEnglish
          : nameEnglish // ignore: cast_nullable_to_non_nullable
              as String,
      nameJapanese: null == nameJapanese
          ? _value.nameJapanese
          : nameJapanese // ignore: cast_nullable_to_non_nullable
              as String,
      nameChinese: null == nameChinese
          ? _value.nameChinese
          : nameChinese // ignore: cast_nullable_to_non_nullable
              as String,
      nameFrench: null == nameFrench
          ? _value.nameFrench
          : nameFrench // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>,
      baseStats: null == baseStats
          ? _value._baseStats
          : baseStats // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PokemonImpl implements _Pokemon {
  const _$PokemonImpl(
      {required this.id,
      required this.nameEnglish,
      required this.nameJapanese,
      required this.nameChinese,
      required this.nameFrench,
      required final List<String> type,
      required final Map<String, int> baseStats})
      : _type = type,
        _baseStats = baseStats;

  factory _$PokemonImpl.fromJson(Map<String, dynamic> json) =>
      _$$PokemonImplFromJson(json);

  @override
  final int id;
  @override
  final String nameEnglish;
  @override
  final String nameJapanese;
  @override
  final String nameChinese;
  @override
  final String nameFrench;
  final List<String> _type;
  @override
  List<String> get type {
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_type);
  }

  final Map<String, int> _baseStats;
  @override
  Map<String, int> get baseStats {
    if (_baseStats is EqualUnmodifiableMapView) return _baseStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_baseStats);
  }

  @override
  String toString() {
    return 'Pokemon(id: $id, nameEnglish: $nameEnglish, nameJapanese: $nameJapanese, nameChinese: $nameChinese, nameFrench: $nameFrench, type: $type, baseStats: $baseStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PokemonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameEnglish, nameEnglish) ||
                other.nameEnglish == nameEnglish) &&
            (identical(other.nameJapanese, nameJapanese) ||
                other.nameJapanese == nameJapanese) &&
            (identical(other.nameChinese, nameChinese) ||
                other.nameChinese == nameChinese) &&
            (identical(other.nameFrench, nameFrench) ||
                other.nameFrench == nameFrench) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            const DeepCollectionEquality()
                .equals(other._baseStats, _baseStats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nameEnglish,
      nameJapanese,
      nameChinese,
      nameFrench,
      const DeepCollectionEquality().hash(_type),
      const DeepCollectionEquality().hash(_baseStats));

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PokemonImplCopyWith<_$PokemonImpl> get copyWith =>
      __$$PokemonImplCopyWithImpl<_$PokemonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PokemonImplToJson(
      this,
    );
  }
}

abstract class _Pokemon implements Pokemon {
  const factory _Pokemon(
      {required final int id,
      required final String nameEnglish,
      required final String nameJapanese,
      required final String nameChinese,
      required final String nameFrench,
      required final List<String> type,
      required final Map<String, int> baseStats}) = _$PokemonImpl;

  factory _Pokemon.fromJson(Map<String, dynamic> json) = _$PokemonImpl.fromJson;

  @override
  int get id;
  @override
  String get nameEnglish;
  @override
  String get nameJapanese;
  @override
  String get nameChinese;
  @override
  String get nameFrench;
  @override
  List<String> get type;
  @override
  Map<String, int> get baseStats;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PokemonImplCopyWith<_$PokemonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
