import 'package:flutter/material.dart';

class TelaMeusPokemons extends StatelessWidget {
  const TelaMeusPokemons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pokemons"),
      ),
      body: Center(
        child: Text("Lista dos meus Pokemons"),
      ),
    );
  }
}
