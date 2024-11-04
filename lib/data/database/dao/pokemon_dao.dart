import 'dart:convert'; // Adicione essa importação
import 'package:sqflite/sqflite.dart';
import 'base_dao.dart';
import '../entity/pokemon_database_entity.dart';

class PokemonDao extends BaseDao {
  Future<List<PokemonDatabaseEntity>> selectAll({
    int? limit,
    int? offset,
  }) async {
    final Database db = await getDb();
    final List<Map<String, dynamic>> maps = await db.query(
      PokemonDatabaseContract.pokemonTable,
      limit: limit,
      offset: offset,
      orderBy: '${PokemonDatabaseContract.idColumn} ASC',
    );

    // Log para verificar os dados retornados
    print('Dados do banco de dados: $maps');

    return List.generate(maps.length, (i) {
      return PokemonDatabaseEntity.fromJson(maps[i]);
    });
  }

  Future<void> insert(PokemonDatabaseEntity entity) async {
    final Database db = await getDb();
    await db.insert(
      PokemonDatabaseContract.pokemonTable,
      {
        'id': entity.id,
        'name': entity.name,
        'type':
            jsonEncode(entity.type), // Convertendo a lista de tipos para JSON
        'base': jsonEncode(entity.base), // Convertendo o mapa de base para JSON
        'imagem': entity.imagem,
      },
    );
  }

  Future<void> insertAll(List<PokemonDatabaseEntity> entities) async {
    final Database db = await getDb();
    await db.transaction((transaction) async {
      for (final entity in entities) {
        print(
            'Inserindo Pokémon: ${entity.toJson()}'); // Log dos dados que estão sendo inseridos
        await transaction.insert(
          PokemonDatabaseContract.pokemonTable,
          {
            'id': entity.id,
            'name': entity.name,
            'type': jsonEncode(
                entity.type), // Convertendo a lista de tipos para JSON
            'base':
                jsonEncode(entity.base), // Convertendo o mapa de base para JSON
            'imagem': entity.imagem,
          },
        );
      }
    });
  }

  Future<void> deleteAll() async {
    final Database db = await getDb();
    await db.delete(PokemonDatabaseContract.pokemonTable);
  }
}
