import 'package:flutter/material.dart';
import 'package:projeto_primeira_unidade/data/database/dao/equipe_dao.dart';
import 'package:projeto_primeira_unidade/data/database/entity/equipe_entity.dart';
import 'package:projeto_primeira_unidade/data/repository/pokemon_repositoy_impl.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/pokemon.dart';
import '../ui/widget/button_widget.dart';
import '../ui/widget/type_chip.dart';

class TelaEncontroDiario extends StatefulWidget {
  const TelaEncontroDiario({super.key});

  @override
  _TelaEncontroDiarioState createState() => _TelaEncontroDiarioState();
}

class _TelaEncontroDiarioState extends State<TelaEncontroDiario> {
  Future<Pokemon>? _randomPokemonFuture;
  late SharedPreferences _prefs;
  static const String _pokemonKey = 'dailyPokemon';
  static const String _dateKey = 'dailyPokemonDate';

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _randomPokemonFuture = fetchRandomPokemon();
    });
  }

  Future<Pokemon> fetchRandomPokemon() async {
    final today = DateTime.now().toString().substring(0, 10);
    final storedDate = _prefs.getString(_dateKey);
    final storedPokemonId = _prefs.getInt(_pokemonKey);

    if (storedDate == today && storedPokemonId != null) {
      final repository =
          Provider.of<PokemonRepositoryImpl>(context, listen: false);
      final pokemons = await repository.getPokemons(page: 1, limit: 809);
      final cachedPokemon = pokemons.firstWhere((p) => p.id == storedPokemonId);
      return cachedPokemon;
    }

    final repository =
        Provider.of<PokemonRepositoryImpl>(context, listen: false);
    final pokemons = await repository.getPokemons(page: 1, limit: 809);
    final randomIndex = Random().nextInt(pokemons.length);
    final randomPokemon = pokemons[randomIndex];

    await _prefs.setString(_dateKey, today);
    await _prefs.setInt(_pokemonKey, randomPokemon.id);

    return randomPokemon;
  }

  Future<void> capturePokemon(Pokemon pokemon) async {
    final captured = _prefs.getBool('captured_${pokemon.id}') ?? false;
    if (captured) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Este Pokémon já foi capturado hoje!")),
      );
      return;
    }
    final equipeDao = Provider.of<EquipeDao>(context, listen: false);

    // Verificar a quantidade de Pokémon na equipe
    final currentTeam = await equipeDao.findAllPokemons();
    if (currentTeam.length >= 6) {
      // Mostrar mensagem e voltar para a tela anterior
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Equipe cheia! Não é possível capturar mais Pokémons.")),
      );
      Navigator.pop(context); // Voltar para a tela anterior
      return;
    }

    // Criar uma nova instância de EquipeEntity a partir do Pokémon
    final equipeEntity = EquipeEntity(pokemonId: pokemon.id);

    // Inserir no banco de dados
    await equipeDao.insertPokemon(equipeEntity);
    _prefs.setBool('captured_${pokemon.id}', true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pokémon capturado com sucesso!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encontro Diário"),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/pokemon_diario.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: FutureBuilder<Pokemon>(
              future: _randomPokemonFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Erro: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final pokemon = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        pokemon.imagem,
                        height: 200,
                        width: 200,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error, size: 100),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        pokemon.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        children: pokemon.type
                            .map((type) => TypeChip(type: type))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            text: 'Capturar',
                            onPressed: () => capturePokemon(pokemon),
                          ),
                          CustomButton(
                            text: 'Fugir',
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Text("Nenhum Pokémon encontrado.",
                      style: TextStyle(color: Colors.white));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
