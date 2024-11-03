import '../../domain/pokemon.dart';
import './entity/pokemon_entity.dart';

class NetworkMapper {
  Pokemon toPokemon(PokemonEntity entity) {
    return Pokemon(
      id: int.parse(entity.id),
      nameEnglish: entity.name['english'] ?? '',
      nameJapanese: entity.name['japanese'] ?? '',
      nameChinese: entity.name['chinese'] ?? '',
      nameFrench: entity.name['french'] ?? '',
      type: entity.type,
      baseStats: Map<String, int>.from(entity.base),
    );
  }

  List<Pokemon> toPokemons(List<PokemonEntity> entities) {
    return entities.map((e) => toPokemon(e)).toList();
  }
}
