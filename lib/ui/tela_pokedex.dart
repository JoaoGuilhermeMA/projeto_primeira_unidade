import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:projeto_primeira_unidade/domain/pokemon.dart';
import 'package:projeto_primeira_unidade/data/repository/pokemon_repositoy_impl.dart';
import './widget/pokemon_item_list.dart';
import 'pokemon_detalhes.dart'; // Importe a tela de detalhes

class TelaPokedex extends StatefulWidget {
  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<TelaPokedex> {
  static const _pageSize = 20;
  final PagingController<int, Pokemon> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPokemons(pageKey);
    });
  }

  Future<void> _fetchPokemons(int pageKey) async {
    try {
      final repository =
          Provider.of<PokemonRepositoryImpl>(context, listen: false);
      final pokemons =
          await repository.getPokemons(page: pageKey, limit: _pageSize);

      final isLastPage = pokemons.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(pokemons);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(pokemons, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List'),
      ),
      body: PagedListView<int, Pokemon>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Pokemon>(
          itemBuilder: (context, pokemon, index) {
            return PokemonListItem(
              pokemon: pokemon,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailScreen(pokemon: pokemon),
                  ),
                );
              },
            );
          },
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
