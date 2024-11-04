// lib/providers/pokemon_provider.dart
import 'package:flutter/material.dart';
import '../data/repository/pokemon_repository.dart';
import '../domain/pokemon.dart';

class PokemonProvider with ChangeNotifier {
  final PokemonRepository repository;
  List<Pokemon> pokemons = [];
  bool isLoading = false;
  bool isLastPage = false;
  int currentPageKey = 0;
  final int pageSize = 20;

  PokemonProvider(this.repository);

  Future<void> fetchPokemons() async {
    isLoading = true;
    notifyListeners();

    try {
      final newPokemons = await repository.fetchPokemons();
      pokemons = newPokemons; // Atualiza a lista de Pokémons com todos
      isLastPage =
          newPokemons.length < pageSize; // Verifica se é a última página
    } catch (error) {
      print('Erro ao carregar Pokémons: $error');
      // Aqui você pode implementar lógica adicional de fallback, se necessário
    } finally {
      isLoading = false;
      notifyListeners(); // Notifica que o estado mudou
    }
  }

  Future<void> fetchMorePokemons() async {
    if (isLastPage || isLoading)
      return; // Se já estiver na última página ou se está carregando, não faz nada

    isLoading = true;
    notifyListeners();

    try {
      final newPokemons = await repository
          .fetchPokemons(); // Usando o mesmo método para exemplo
      pokemons.addAll(newPokemons); // Adiciona novos Pokémons à lista existente
      isLastPage =
          newPokemons.length < pageSize; // Atualiza se é a última página
      currentPageKey++; // Atualiza a chave da página
    } catch (error) {
      print('Erro ao carregar mais Pokémons: $error');
      // Lógica de fallback pode ser implementada aqui
    } finally {
      isLoading = false;
      notifyListeners(); // Notifica que o estado mudou
    }
  }
}
