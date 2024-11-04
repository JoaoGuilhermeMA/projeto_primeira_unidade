import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Adicione esta linha
import 'data/repository/pokemon_repositoy_impl.dart';
import 'data/database/app_database.dart';
import 'data/database/database_mapper.dart';
import 'providers/pokemon_provider.dart'; // Importar o seu PokemonProvider
import 'ui/tela_inial.dart';
import 'ui/tela_pokedex.dart';
import 'ui/tela_encontro_diario.dart';
import 'ui/tela_meus_pokemons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o banco de dados
  final database =
      await $FloorAppDatabase.databaseBuilder('pokemon_database.db').build();
  final pokemonDao = database.pokemonDao;
  final databaseMapper = DatabaseMapper();

  final pokemonRepository = PokemonRepositoryImpl(
    'http://192.168.0.34:3000/pokedex',
    pokemonDao,
    databaseMapper,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => PokemonProvider(pokemonRepository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POKEDEX',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/telaPokedex': (context) => TelaPokedex(),
        '/telaEncontroDiario': (context) => TelaEncontroDiario(),
        '/telaMeusPokemons': (context) => TelaMeusPokemons(),
      },
    );
  }
}
