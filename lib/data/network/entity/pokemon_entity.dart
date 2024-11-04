import 'package:json_annotation/json_annotation.dart';

part 'pokemon_entity.g.dart';

@JsonSerializable()
class PokemonEntity {
  final int id;
  final String name;
  final List<String> type;
  final Map<String, int> base;
  final String imagem;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
    required this.imagem,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) =>
      _$PokemonEntityFromJson(json);
}
