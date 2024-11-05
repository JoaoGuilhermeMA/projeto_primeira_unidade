import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/pokemon.dart';
import '../providers/pokemon_provider.dart';
import './widget/pokemon_item_list.dart';
import 'pokemon_detalhes.dart';

class TelaPokedex extends StatefulWidget {
  const TelaPokedex({super.key});

  @override
  _TelaPokedexState createState() => _TelaPokedexState();
}

class _TelaPokedexState extends State<TelaPokedex> {
  late ScrollController _scrollController;
  int _pageKey = 0;
  final int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialPage();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchInitialPage() async {
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    print("Fetching initial data from API...");
    await provider
        .fetchAllPokemons(); // Chama a API para buscar todos os Pokémons
  }

  void _onScroll() {
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !provider.isLastPage &&
        !provider.isLoading) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    _pageKey++;
    print("Loading more data from API with offset $_pageKey...");
    await provider.fetchPokemonsPaginated(_pageKey, _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
      ),
      body: provider.isLoading && provider.pokemons.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : provider.pokemons.isEmpty
              ? const Center(child: Text("Nenhum Pokémon encontrado."))
              : ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      provider.pokemons.length + (provider.isLastPage ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (index < provider.pokemons.length) {
                      final pokemon = provider.pokemons[index];
                      return PokemonListItem(
                        pokemon: pokemon,
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
                    } else {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
    );
  }
}
