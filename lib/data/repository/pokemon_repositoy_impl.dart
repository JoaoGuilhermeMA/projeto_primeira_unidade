import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:projeto_primeira_unidade/data/database/entity/pokemon_database_entity.dart';
import 'package:projeto_primeira_unidade/data/network/client/pokemon_api_client.dart';
import 'package:projeto_primeira_unidade/data/network/network_mapper.dart';
import '../../domain/pokemon.dart';
import '../repository/pokemon_repository.dart';
import '../database/dao/pokemon_dao.dart';
import '../database/database_mapper.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDao pokemonDao;
  final DatabaseMapper databaseMapper;
  final PokemonApiClient apiClient;
  final NetworkMapper networkMapper;

  PokemonRepositoryImpl(
      {required this.pokemonDao,
      required this.databaseMapper,
      required this.apiClient,
      required this.networkMapper});

  Future<List<Pokemon>> getPokemons(
      {required int page, required int limit}) async {
    final offset =
        (page - 1) * limit; // Corrigido para que a primeira página comece em 0
    print("Requesting page: $page, limit: $limit, offset: $offset");

    final pokemonEntitys =
        await pokemonDao.selectPokemonsPaginated(limit, offset);

    print(
        "Pokémons retornados: ${pokemonEntitys.length}"); // Verifique quantos pokémons foram retornados
    if (pokemonEntitys.isNotEmpty) {
      print("\n\nto no if");
      return databaseMapper.toPokemons(pokemonEntitys);
    }
    print("to no else");
    final internetEntity = await apiClient.fetchPokemons();
    final pokemons = networkMapper.toPokemons(internetEntity);
    await pokemonDao.insertAll(
      pokemons.map(databaseMapper.toPokemonDatabaseEntity).toList(),
    );
    return pokemons;
  }
}
