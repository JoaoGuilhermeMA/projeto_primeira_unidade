import 'package:floor/floor.dart';
import '../entity/equipe_entity.dart';

@dao
abstract class EquipeDao {
  @insert
  Future<void> insertPokemon(EquipeEntity equipe);

  @Query('SELECT * FROM equipe')
  Future<List<EquipeEntity>> findAllPokemons();

  @delete
  Future<void> deletePokemon(EquipeEntity equipe);

  @Query('DELETE FROM equipe WHERE pokemonId = :pokemonId')
  Future<void> deletePokemonByPokemonId(int pokemonId);
}
