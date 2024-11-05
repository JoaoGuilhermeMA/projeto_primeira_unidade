import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../domain/pokemon.dart';
import '../providers/pokemon_provider.dart';
import './widget/type_chip.dart';
import 'pokemon_detalhes.dart';

class TelaPokedex extends StatefulWidget {
  const TelaPokedex({super.key});

  @override
  _TelaPokedexState createState() => _TelaPokedexState();
}

class _TelaPokedexState extends State<TelaPokedex> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _fetchInitialPage();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchInitialPage() async {
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    await provider.fetchPokemons();
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
    await provider.fetchMorePokemons();
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
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: pokemon.imagem,
                          width: 50,
                          height: 50,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(pokemon.name),
                        subtitle: Wrap(
                          spacing: 8,
                          children: pokemon.type
                              .map((type) => TypeChip(type: type))
                              .toList(),
                        ),
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
