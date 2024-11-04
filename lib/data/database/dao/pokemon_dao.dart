import 'package:floor/floor.dart';
import '../entity/pokemon_database_entity.dart';

@dao
abstract class PokemonDao {
  @Query('SELECT * FROM PokemonDatabaseEntity')
  Future<List<PokemonDatabaseEntity>> selectAllPokemons();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<PokemonDatabaseEntity> entities);

  @Query('DELETE FROM PokemonDatabaseEntity')
  Future<void> deleteAll();

  // Novo método para buscar um Pokémon pelo ID
  @Query('SELECT * FROM PokemonDatabaseEntity WHERE id = :id')
  Future<PokemonDatabaseEntity?> findPokemonById(int id);

  @Query('SELECT * FROM PokemonDatabaseEntity LIMIT :limit OFFSET :offset')
  Future<List<PokemonDatabaseEntity>> selectPokemonsPaginated(
      int limit, int offset);
}
