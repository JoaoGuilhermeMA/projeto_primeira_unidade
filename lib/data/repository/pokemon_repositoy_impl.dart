import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:projeto_primeira_unidade/data/database/entity/pokemon_database_entity.dart';
import '../../domain/pokemon.dart';
import '../repository/pokemon_repository.dart';
import '../database/dao/pokemon_dao.dart';
import '../database/database_mapper.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final String baseUrl;
  final PokemonDao pokemonDao;
  final DatabaseMapper databaseMapper;

  PokemonRepositoryImpl(this.baseUrl, this.pokemonDao, this.databaseMapper);

  Future<List<PokemonDatabaseEntity>> fetchPokemonsPaginated(
      int limit, int offset) async {
    return await pokemonDao.selectPokemonsPaginated(limit, offset);
  }

  @override
  Future<List<Pokemon>> fetchPokemons() async {
    print("entrei aqui");
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> jsonResponse = jsonDecode(res.body);
        final List<dynamic> pokemonsJson =
            jsonResponse['pokedex'] as List<dynamic>;

        final pokemons =
            pokemonsJson.map((json) => Pokemon.fromJson(json)).toList();

        await pokemonDao.deleteAll(); // Limpa a tabela
        await pokemonDao.insertAll(
          pokemons.map(databaseMapper.toPokemonDatabaseEntity).toList(),
        );

        return pokemons;
      } else {
        throw 'Erro de conexão: ${res.statusCode}';
      }
    } catch (error) {
      print('Erro ao pegar pokémons da API: $error');

      // Fallback para o banco de dados se houver erro
      final pokemonEntities = await pokemonDao
          .selectAllPokemons(); // Alterado para selectAllPokemons
      if (pokemonEntities.isEmpty) {
        print('Nenhum Pokémon encontrado no banco de dados.');
      } else {
        print(
            'Pokémons encontrados no banco de dados: ${pokemonEntities.length}');
      }
      final cachedPokemons =
          pokemonEntities.map(databaseMapper.toPokemon).toList();

      return cachedPokemons;
    }
  }
}
