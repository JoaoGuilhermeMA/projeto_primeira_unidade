import 'package:flutter/material.dart';
import '../domain/pokemon.dart';
import '../data/network/client/pokemon_api_client.dart';
import '../data/network/network_mapper.dart';

class TelaPokedex extends StatefulWidget {
  const TelaPokedex({super.key});

  @override
  _TelaPokedexState createState() => _TelaPokedexState();
}

class _TelaPokedexState extends State<TelaPokedex> {
  List<Pokemon> pokemons = [];
  bool isLoading = true;
  final PokemonApiClient pokemonApiClient =
      PokemonApiClient(baseUrl: 'http://192.168.0.34:3000');
  final NetworkMapper networkMapper = NetworkMapper();

  @override
  void initState() {
    super.initState();
    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    try {
      final pokemonEntities = await pokemonApiClient.fetchPokemons();
      setState(() {
        pokemons = networkMapper.toPokemons(pokemonEntities);
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
        title: const Text("Pokedex"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
