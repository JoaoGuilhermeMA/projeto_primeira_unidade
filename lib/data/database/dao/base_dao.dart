import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../entity/pokemon_database_entity.dart';

abstract class BaseDao {
  static const databaseVersion = 3; // Aumente a versão
  static const _databaseName = 'pokemon_database.db';

  Database? _database;

  @protected
  Future<Database> getDb() async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        final batch = db.batch();
        _createPokemonTableV1(batch);
        await batch.commit();
      },
      version: databaseVersion,
    );
  }

  void _createPokemonTableV1(Batch batch) {
    batch.execute('''
    CREATE TABLE IF NOT EXISTS ${PokemonDatabaseContract.pokemonTable} (
      ${PokemonDatabaseContract.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PokemonDatabaseContract.nameColumn} TEXT NOT NULL,
      ${PokemonDatabaseContract.typeColumn} TEXT NOT NULL, -- Armazenado como JSON
      ${PokemonDatabaseContract.baseColumn} TEXT NOT NULL, -- Armazenado como JSON
      ${PokemonDatabaseContract.imagemColumn} TEXT NOT NULL
    );
    ''');
  }
}

class PokemonDatabaseContract {
  static const String pokemonTable = 'pokemons';
  static const String idColumn = 'id';
  static const String nameColumn = 'name';
  static const String typeColumn = 'type'; // Armazenado como JSON
  static const String baseColumn = 'base'; // Corrigido se necessário
  static const String imagemColumn = 'imagem';
}
