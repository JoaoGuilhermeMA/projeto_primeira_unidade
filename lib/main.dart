import 'package:flutter/material.dart';
import 'package:projeto_primeira_unidade/core/configure_providers.dart';
import 'package:provider/provider.dart';
import 'ui/tela_inial.dart';
import 'ui/tela_pokedex.dart';
import 'ui/tela_encontro_diario.dart';
import 'ui/tela_meus_pokemons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configura os providers
  final configureProviders = await ConfigureProviders.createDependencyTree();

  runApp(
    MultiProvider(
      providers: configureProviders.providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
