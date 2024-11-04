import './entity/pokemon_database_entity.dart';
import '../../domain/pokemon.dart';
import '../../exceptions/mapper_exception.dart';

class DatabaseMapper {
  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    try {
      return Pokemon(
        id: entity.id,
        name: entity.name,
        type: entity.type,
        base: entity.base,
        imagem: entity.imagem,
      );
    } catch (e) {
      throw MapperException<PokemonDatabaseEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<PokemonDatabaseEntity> entities) {
    return entities.map((entity) => toPokemon(entity)).toList();
  }

  PokemonDatabaseEntity toPokemonDatabaseEntity(Pokemon pokemon) {
    try {
      return PokemonDatabaseEntity(
        id: pokemon.id,
        name: pokemon.name,
        type: pokemon.type,
        base: pokemon.base,
        imagem: pokemon.imagem,
      );
    } catch (e) {
      throw MapperException<Pokemon, PokemonDatabaseEntity>(e.toString());
    }
  }

  List<PokemonDatabaseEntity> toPokemonDatabaseEntities(
      List<Pokemon> pokemons) {
    return pokemons.map((pokemon) => toPokemonDatabaseEntity(pokemon)).toList();
  }
}
