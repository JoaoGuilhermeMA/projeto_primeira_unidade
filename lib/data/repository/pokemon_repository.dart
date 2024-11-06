import 'package:projeto_primeira_unidade/data/database/entity/pokemon_database_entity.dart';

import '../../domain/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons({required int page, required int limit});
}
