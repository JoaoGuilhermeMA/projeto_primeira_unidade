import 'dart:convert';
import 'package:floor/floor.dart';

@entity
class PokemonDatabaseEntity {
  @primaryKey
  final int id;
  final String name;
  final String type;
  final String base;
  final String imagem;

  PokemonDatabaseEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
    required this.imagem,
  });

  // Método para converter `type` de JSON string para lista
  List<String> getTypeList() => List<String>.from(jsonDecode(type));

  // Método para converter `base` de JSON string para mapa
  Map<String, int> getBaseMap() => Map<String, int>.from(jsonDecode(base));

  // Métodos para converter listas e mapas para JSON
  static String typeToJson(List<String> typeList) => jsonEncode(typeList);

  static String baseToJson(Map<String, int> baseMap) => jsonEncode(baseMap);
}
