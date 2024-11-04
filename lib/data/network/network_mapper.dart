import '../../domain/pokemon.dart';
import './entity/pokemon_entity.dart';

class NetworkMapper {
  Pokemon toPokemon(PokemonEntity entity) {
    return Pokemon(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      base: Map<String, int>.from(entity.base),
      imagem: entity.imagem,
    );
  }

  List<Pokemon> toPokemons(List<PokemonEntity> entities) {
    return entities.map((e) => toPokemon(e)).toList();
  }
}
