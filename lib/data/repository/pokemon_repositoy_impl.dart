import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../domain/pokemon.dart';
import '../repository/pokemon_repository.dart';
import '../database/dao/pokemon_dao.dart';
import '../database/database_mapper.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final String baseUrl;
  final PokemonDao pokemonDao;
  final DatabaseMapper databaseMapper;

  PokemonRepositoryImpl(this.baseUrl, this.pokemonDao, this.databaseMapper);

  @override
  Future<List<Pokemon>> fetchPokemons() async {
    try {
      // Tentar buscar os dados da API
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == HttpStatus.ok) {
        final Map<String, dynamic> jsonResponse = jsonDecode(res.body);

        final List<dynamic> pokemonsJson =
            jsonResponse['pokedex'] as List<dynamic>; // Acessando 'pokedex'

        // print('Pokémons da API: $pokemonsJson'); // Log dos dados recebidos

        final pokemons =
            pokemonsJson.map((json) => Pokemon.fromJson(json)).toList();

        // Salvar no banco de dados
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
      final pokemonEntities = await pokemonDao.selectAll();
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
