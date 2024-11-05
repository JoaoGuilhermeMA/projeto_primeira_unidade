import 'package:flutter/material.dart';
import 'package:projeto_primeira_unidade/data/database/database_mapper.dart';
import '../data/repository/pokemon_repository.dart';
import '../domain/pokemon.dart';

class PokemonProvider with ChangeNotifier {
  final PokemonRepository repository;
  final DatabaseMapper databaseMapper =
      DatabaseMapper(); // Instância de DatabaseMapper
  List<Pokemon> pokemons = [];
  bool isLoading = false;
  bool isLastPage = false;
  final int pageSize = 20;

  PokemonProvider(this.repository);

  Future<List<Pokemon>> fetchPokemonsPaginated(
      int pageKey, int pageSize) async {
    isLoading = true;
    notifyListeners();

    try {
      final offset = pageKey * pageSize;
      final pokemonEntities =
          await repository.fetchPokemonsPaginated(pageSize, offset);
      final newPokemons = pokemonEntities
          .map((entity) => databaseMapper
              .toPokemon(entity)) // Usa o mapper para converter para `Pokemon`
          .toList();

      isLastPage = newPokemons.length < pageSize;
      return newPokemons;
    } catch (error) {
      print('Erro ao carregar Pokémons: $error');
      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
