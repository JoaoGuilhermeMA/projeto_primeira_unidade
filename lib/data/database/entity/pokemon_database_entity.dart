import 'package:json_annotation/json_annotation.dart';
import '../dao/base_dao.dart';
import 'dart:convert';

part 'pokemon_database_entity.g.dart';

@JsonSerializable()
class PokemonDatabaseEntity {
  final int id;
  final String name;
  final List<String> type;
  final Map<String, int> base;
  final String imagem;

  PokemonDatabaseEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
    required this.imagem,
  });

  factory PokemonDatabaseEntity.fromJson(Map<String, dynamic> json) {
    return PokemonDatabaseEntity(
      id: json[PokemonDatabaseContract.idColumn] as int,
      name: json[PokemonDatabaseContract.nameColumn] as String,
      type: List<String>.from(jsonDecode(json[PokemonDatabaseContract
          .typeColumn])), // Certifique-se de que isso está decodificando corretamente
      base: Map<String, int>.from(jsonDecode(json[PokemonDatabaseContract
          .baseColumn])), // Certifique-se de que isso está decodificando corretamente
      imagem: json[PokemonDatabaseContract.imagemColumn] as String,
    );
  }

  Map<String, dynamic> toJson() => _$PokemonDatabaseEntityToJson(this);
}
