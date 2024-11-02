import 'package:flutter/material.dart';
import 'screens/tela_inial.dart';
import 'screens/tela_pokedex.dart';
import 'screens/tela_encontro_diario.dart';
import 'screens/tela_meus_pokemons.dart';

void main() {
  runApp(MyApp());
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
