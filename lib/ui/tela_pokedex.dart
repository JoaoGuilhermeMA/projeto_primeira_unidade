import 'package:flutter/material.dart';
import '../domain/pokemon.dart';
import '../data/repository/pokemon_repositoy_impl.dart';
import '../data/database/app_database.dart';
import '../data/database/database_mapper.dart';
import 'pokemon_detalhes.dart';

class TelaPokedex extends StatefulWidget {
  const TelaPokedex({super.key});

  @override
  _TelaPokedexState createState() => _TelaPokedexState();
}

class _TelaPokedexState extends State<TelaPokedex> {
  List<Pokemon> pokemons = [];
  bool isLoading = true;
  String? errorMessage;

  late final PokemonRepositoryImpl pokemonRepository;

  @override
  void initState() {
    super.initState();
    initializeRepository();
  }

  Future<void> initializeRepository() async {
    // Instanciar o banco de dados e obter o PokemonDao e DatabaseMapper
    final database =
        await $FloorAppDatabase.databaseBuilder('pokemon_database.db').build();
    final pokemonDao = database.pokemonDao;
    final databaseMapper = DatabaseMapper();

    // Inicializar o repositório com o dao e mapper
    pokemonRepository = PokemonRepositoryImpl(
      'http://192.168.0.34:3000/pokedex',
      pokemonDao,
      databaseMapper,
    );

    fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      pokemons = await pokemonRepository.fetchPokemons();
    } catch (error) {
      print('Erro ao carregar pokémons: $error');
      setState(() {
        errorMessage =
            'Erro ao carregar os dados. Mostrando dados em cache, se disponíveis.';
      });
    } finally {
      setState(() => isLoading = false);
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
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage!),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: fetchPokemons,
                        child: const Text("Tentar novamente"),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: pokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemons[index];
                    return ListTile(
                      leading: Image.network(
                        pokemon.imagem,
                        width: 50,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      ),
                      title: Text(pokemon.name),
                      subtitle: Text("Tipo: ${pokemon.type.join(", ")}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PokemonDetailScreen(pokemon: pokemon),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
