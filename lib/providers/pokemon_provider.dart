import 'package:flutter/material.dart';
import 'package:projeto_primeira_unidade/data/database/database_mapper.dart';
import '../data/repository/pokemon_repository.dart';
import '../domain/pokemon.dart';

class PokemonProvider with ChangeNotifier {
  final PokemonRepository repository;
  final DatabaseMapper databaseMapper = DatabaseMapper();
  List<Pokemon> pokemons = [];
  bool isLoading = false;
  bool isLastPage = false;
  final int pageSize = 20;

  PokemonProvider(this.repository);

  Future<void> fetchAllPokemons() async {
    isLoading = true;
    notifyListeners();

    try {
      // Tenta buscar os pokémons da API
      pokemons = await repository.fetchPokemons();
      isLastPage = pokemons.length < pageSize;
    } catch (error) {
      print('Erro ao carregar Pokémons da API: $error');
      // Se houver erro, já é tratado pelo repositório com fallback para o banco de dados
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Pokemon>> fetchPokemonsPaginated(
      int pageKey, int pageSize) async {
    isLoading = true;
    notifyListeners();

    try {
      final offset = pageKey * pageSize;
      final pokemonEntities =
          await repository.fetchPokemonsPaginated(pageSize, offset);
      final newPokemons = pokemonEntities
          .map((entity) => databaseMapper.toPokemon(entity))
          .toList();

      isLastPage = newPokemons.length < pageSize;
      pokemons.addAll(newPokemons);
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
