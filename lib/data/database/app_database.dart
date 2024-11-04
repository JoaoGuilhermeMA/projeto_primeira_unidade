import 'package:floor/floor.dart';
import 'entity/pokemon_database_entity.dart';
import 'entity/equipe_entity.dart';
import 'dao/pokemon_dao.dart';
import 'dao/equipe_dao.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [PokemonDatabaseEntity, EquipeEntity])
abstract class AppDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
  EquipeDao get equipeDao;
}
