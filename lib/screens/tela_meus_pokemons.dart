import 'package:flutter/material.dart';
import '../data/database/app_database.dart';
import '../data/database/dao/equipe_dao.dart';
import '../data/database/dao/pokemon_dao.dart'; // Importar o PokemonDao
import '../data/database/database_mapper.dart'; // Importe o mapeador, se necessário
import '../domain/pokemon.dart'; // Importar o modelo Pokémon
import './meu_pokemon_detalhe.dart'; // Importar a tela de detalhes com liberação

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
    final pokemonDao = database.pokemonDao; // Instanciar o PokemonDao

    final capturados =
        await equipeDao.findAllPokemons(); // Busca todos os Pokémon da equipe
    final List<Pokemon> pokemons = [];

    // Para cada Pokémon capturado, buscar as informações correspondentes na tabela pokemon
    for (final equipe in capturados) {
      final pokemonEntity = await pokemonDao
          .findPokemonById(equipe.pokemonId); // Busca o Pokémon pelo ID
      if (pokemonEntity != null) {
        final databaseMapper = DatabaseMapper();
        final pokemon = databaseMapper
            .toPokemon(pokemonEntity); // Converte a entidade para o modelo
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
                return ListTile(
                  title: Text(pokemon.name),
                  subtitle: Text("ID: ${pokemon.id}"),
                  leading: Image.network(
                    pokemon.imagem,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 50),
                  ),
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
