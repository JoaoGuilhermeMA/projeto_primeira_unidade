import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../domain/pokemon.dart';
import '../providers/pokemon_provider.dart';
import './widget/type_chip.dart'; // Import do TypeChip
import 'pokemon_detalhes.dart';

class TelaPokedex extends StatefulWidget {
  const TelaPokedex({super.key});

  @override
  _TelaPokedexState createState() => _TelaPokedexState();
}

class _TelaPokedexState extends State<TelaPokedex> {
  @override
  void initState() {
    super.initState();
    _fetchInitialPage();
  }

  Future<void> _fetchInitialPage() async {
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    await provider.fetchPokemons(); // Carrega todos os Pokémons inicialmente
  }

  Future<void> _loadMoreData() async {
    final provider = Provider.of<PokemonProvider>(context, listen: false);
    await provider
        .fetchMorePokemons(); // Carrega mais Pokémons se não for a última página
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
      ),
      body: provider.isLoading && provider.pokemons.isEmpty
          ? const Center(
              child: CircularProgressIndicator()) // Mostra indicador de loading
          : ListView.builder(
              itemCount: provider.pokemons.length +
                  (provider.isLastPage
                      ? 0
                      : 1), // Adiciona um item extra para carregamento se não for a última página
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
                      spacing: 8, // Espaçamento entre os chips
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
                  // Carregar mais dados se necessário
                  _loadMoreData(); // Chama a função para carregar mais Pokémons
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                          CircularProgressIndicator(), // Mostra indicador de loading
                    ),
                  );
                }
              },
            ),
    );
  }
}
