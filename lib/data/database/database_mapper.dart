import './entity/pokemon_database_entity.dart';
import '../../domain/pokemon.dart';

class DatabaseMapper {
  PokemonDatabaseEntity toPokemonDatabaseEntity(Pokemon pokemon) {
    return PokemonDatabaseEntity(
      id: pokemon.id,
      name: pokemon.name,
      type: PokemonDatabaseEntity.typeToJson(
          pokemon.type), // Converte a lista para JSON
      base: PokemonDatabaseEntity.baseToJson(
          pokemon.base), // Converte o mapa para JSON
      imagem: pokemon.imagem, // Se houver uma imagem
    );
  }

  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    return Pokemon(
      id: entity.id,
      name: entity.name,
      type: entity.getTypeList(), // Converte JSON para lista
      base: entity.getBaseMap(), // Converte JSON para mapa
      imagem: entity.imagem,
    );
  }

  List<Pokemon> toPokemons(List<PokemonDatabaseEntity> entities) {
    final List<Pokemon> pokemons = [];
    for (var PokemonEntity in entities) {
      pokemons.add(toPokemon(PokemonEntity));
    }
    return pokemons;
  }
}
