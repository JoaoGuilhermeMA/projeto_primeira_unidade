// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PokemonDao? _pokemonDaoInstance;

  EquipeDao? _equipeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PokemonDatabaseEntity` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `base` TEXT NOT NULL, `imagem` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `equipe` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `pokemonId` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonDao get pokemonDao {
    return _pokemonDaoInstance ??= _$PokemonDao(database, changeListener);
  }

  @override
  EquipeDao get equipeDao {
    return _equipeDaoInstance ??= _$EquipeDao(database, changeListener);
  }
}

class _$PokemonDao extends PokemonDao {
  _$PokemonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pokemonDatabaseEntityInsertionAdapter = InsertionAdapter(
            database,
            'PokemonDatabaseEntity',
            (PokemonDatabaseEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'base': item.base,
                  'imagem': item.imagem
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PokemonDatabaseEntity>
      _pokemonDatabaseEntityInsertionAdapter;

  @override
  Future<List<PokemonDatabaseEntity>> selectAllPokemons() async {
    return _queryAdapter.queryList('SELECT * FROM PokemonDatabaseEntity',
        mapper: (Map<String, Object?> row) => PokemonDatabaseEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            type: row['type'] as String,
            base: row['base'] as String,
            imagem: row['imagem'] as String));
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PokemonDatabaseEntity');
  }

  @override
  Future<PokemonDatabaseEntity?> findPokemonById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM PokemonDatabaseEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PokemonDatabaseEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            type: row['type'] as String,
            base: row['base'] as String,
            imagem: row['imagem'] as String),
        arguments: [id]);
  }

  @override
  Future<List<PokemonDatabaseEntity>> selectPokemonsPaginated(
    int limit,
    int offset,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PokemonDatabaseEntity LIMIT ?1 OFFSET ?2',
        mapper: (Map<String, Object?> row) => PokemonDatabaseEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            type: row['type'] as String,
            base: row['base'] as String,
            imagem: row['imagem'] as String),
        arguments: [limit, offset]);
  }

  @override
  Future<void> insertAll(List<PokemonDatabaseEntity> entities) async {
    await _pokemonDatabaseEntityInsertionAdapter.insertList(
        entities, OnConflictStrategy.replace);
  }
}

class _$EquipeDao extends EquipeDao {
  _$EquipeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _equipeEntityInsertionAdapter = InsertionAdapter(
            database,
            'equipe',
            (EquipeEntity item) =>
                <String, Object?>{'id': item.id, 'pokemonId': item.pokemonId}),
        _equipeEntityDeletionAdapter = DeletionAdapter(
            database,
            'equipe',
            ['id'],
            (EquipeEntity item) =>
                <String, Object?>{'id': item.id, 'pokemonId': item.pokemonId});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EquipeEntity> _equipeEntityInsertionAdapter;

  final DeletionAdapter<EquipeEntity> _equipeEntityDeletionAdapter;

  @override
  Future<List<EquipeEntity>> findAllPokemons() async {
    return _queryAdapter.queryList('SELECT * FROM equipe',
        mapper: (Map<String, Object?> row) => EquipeEntity(
            id: row['id'] as int?, pokemonId: row['pokemonId'] as int));
  }

  @override
  Future<void> deletePokemonByPokemonId(int pokemonId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM equipe WHERE pokemonId = ?1',
        arguments: [pokemonId]);
  }

  @override
  Future<void> insertPokemon(EquipeEntity equipe) async {
    await _equipeEntityInsertionAdapter.insert(
        equipe, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePokemon(EquipeEntity equipe) async {
    await _equipeEntityDeletionAdapter.delete(equipe);
  }
}
