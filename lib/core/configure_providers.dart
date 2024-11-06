import 'package:flutter/material.dart';
import 'package:projeto_primeira_unidade/data/network/client/pokemon_api_client.dart';
import 'package:projeto_primeira_unidade/data/repository/pokemon_repositoy_impl.dart';
import 'package:provider/provider.dart';
import '../data/database/app_database.dart';
import '../data/database/dao/equipe_dao.dart';
import '../data/database/database_mapper.dart';
import '../data/network/network_mapper.dart';

class ConfigureProviders {
  final List<Provider> providers;

  ConfigureProviders._(this.providers);

  static Future<ConfigureProviders> createDependencyTree() async {
    // Inicializando o banco de dados
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    // Inicializando as dependências necessárias
    final pokemonDao = database.pokemonDao;
    final equipeDao = database.equipeDao;
    final databaseMapper = DatabaseMapper();
    final apiClient = PokemonApiClient(baseUrl: "http://192.168.0.34:3000");
    final networkMapper = NetworkMapper();

    // Criando o repositório do Pokémon
    final pokemonRepository = PokemonRepositoryImpl(
      pokemonDao: pokemonDao,
      databaseMapper: databaseMapper,
      apiClient: apiClient,
      networkMapper: networkMapper,
    );

    // Configurando os providers
    final providers = [
      Provider<PokemonRepositoryImpl>.value(value: pokemonRepository),
      Provider<EquipeDao>.value(value: equipeDao),
    ];

    return ConfigureProviders._(providers);
  }
}
