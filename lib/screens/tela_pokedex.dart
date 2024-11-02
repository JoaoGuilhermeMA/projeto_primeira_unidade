import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class TelaPokedex extends StatefulWidget {
  const TelaPokedex({super.key});

  @override
  _TelaPokedexState createState() => _TelaPokedexState();
}

class _TelaPokedexState extends State<TelaPokedex> {
  List<Pokemon> pokemons = [];
  bool isLoading = true;
  final PokemonService pokemonService =
      PokemonService('http://192.168.0.34:3000/pokemons');

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    try {
      final pokemonList = await pokemonService.fetchPokemons();
      setState(() {
        pokemons = pokemonList;
        isLoading = false;
      });
    } catch (error) {
      print('Erro ao pegar pokémons: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                return ListTile(
                  title: Text(pokemon.nameEnglish),
                  subtitle: Text("Tipo: ${pokemon.type.join(", ")}"),
                );
              },
            ),
    );
  }
}
