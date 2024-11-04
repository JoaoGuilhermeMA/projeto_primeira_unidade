import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  static const _pageSize = 20; // Tamanho da página (ajuste conforme necessário)

  late final PokemonRepositoryImpl pokemonRepository;
  final PagingController<int, Pokemon> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    initializeRepository();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> initializeRepository() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('pokemon_database.db').build();
    final pokemonDao = database.pokemonDao;
    final databaseMapper = DatabaseMapper();
    pokemonRepository = PokemonRepositoryImpl(
      'http://192.168.0.34:3000/pokedex',
      pokemonDao,
      databaseMapper,
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newPokemons =
          await pokemonRepository.fetchPokemonsPaginated(pageKey, _pageSize);
      final isLastPage = newPokemons.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newPokemons);
      } else {
        final nextPageKey = pageKey + newPokemons.length;
        _pagingController.appendPage(newPokemons, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
      ),
      body: PagedListView<int, Pokemon>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Pokemon>(
          itemBuilder: (context, pokemon, index) => ListTile(
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
                  builder: (context) => PokemonDetailScreen(pokemon: pokemon),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
