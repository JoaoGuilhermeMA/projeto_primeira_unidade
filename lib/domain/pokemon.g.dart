// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonImpl _$$PokemonImplFromJson(Map<String, dynamic> json) =>
    _$PokemonImpl(
      id: (json['id'] as num).toInt(),
      nameEnglish: json['nameEnglish'] as String,
      nameJapanese: json['nameJapanese'] as String,
      nameChinese: json['nameChinese'] as String,
      nameFrench: json['nameFrench'] as String,
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      baseStats: Map<String, int>.from(json['baseStats'] as Map),
    );

Map<String, dynamic> _$$PokemonImplToJson(_$PokemonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameEnglish': instance.nameEnglish,
      'nameJapanese': instance.nameJapanese,
      'nameChinese': instance.nameChinese,
      'nameFrench': instance.nameFrench,
      'type': instance.type,
      'baseStats': instance.baseStats,
    };
