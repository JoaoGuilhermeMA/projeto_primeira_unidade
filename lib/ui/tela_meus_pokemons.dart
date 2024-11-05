import 'package:flutter/material.dart';
import '../data/database/app_database.dart';
import '../domain/pokemon.dart';
import './widget/pokemon_item_list.dart';
import 'meu_pokemon_detalhe.dart';
import '../data/database/database_mapper.dart';

class TelaMeusPokemons extends StatefulWidget {
  const TelaMeusPokemons({super.key});

  @override
  _TelaMeusPokemonsState createState() => _TelaMeusPokemonsState();
}

class _TelaMeusPokemonsState extends State<TelaMeusPokemons> {
  late Future<List<Pokemon>> _pokemonsCapturadosFuture;

  @override
  void initState() {
    super.initState();
    _pokemonsCapturadosFuture = fetchCapturados();
  }

  Future<List<Pokemon>> fetchCapturados() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('pokemon_database.db').build();
    final equipeDao = database.equipeDao;
    final pokemonDao = database.pokemonDao;

    final capturados = await equipeDao.findAllPokemons();
    final List<Pokemon> pokemons = [];

    for (final equipe in capturados) {
      final pokemonEntity = await pokemonDao.findPokemonById(equipe.pokemonId);
      if (pokemonEntity != null) {
        final databaseMapper = DatabaseMapper();
        final pokemon = databaseMapper.toPokemon(pokemonEntity);
        pokemons.add(pokemon);
      }
    }
    return pokemons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Pokémons"),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _pokemonsCapturadosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final pokemons = snapshot.data!;
            return ListView.builder(
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                return PokemonListItem(
                  pokemon: pokemon,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PokemonDetailReleaseScreen(pokemon: pokemon),
                      ),
                    );
                    setState(() {
                      _pokemonsCapturadosFuture = fetchCapturados();
                    });
                  },
                );
              },
            );
          } else {
            return const Center(child: Text("Nenhum Pokémon capturado."));
          }
        },
      ),
    );
  }
}
