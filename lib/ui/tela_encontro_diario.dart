import 'package:flutter/material.dart';
import 'dart:math'; // Importar a biblioteca random
import '../data/database/app_database.dart';
import '../data/database/database_mapper.dart';
import '../domain/pokemon.dart';
import '../data/database/dao/equipe_dao.dart'; // Importar o EquipeDao
import '../data/database/entity/equipe_entity.dart'; // Importar a entidade EquipeEntity
import '../ui/widget/button_widget.dart';

class TelaEncontroDiario extends StatefulWidget {
  const TelaEncontroDiario({super.key});

  @override
  _TelaEncontroDiarioState createState() => _TelaEncontroDiarioState();
}

class _TelaEncontroDiarioState extends State<TelaEncontroDiario> {
  late Future<Pokemon> _randomPokemonFuture;

  @override
  void initState() {
    super.initState();
    _randomPokemonFuture = fetchRandomPokemon();
  }

  Future<Pokemon> fetchRandomPokemon() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('pokemon_database.db').build();
    final pokemonDao = database.pokemonDao;
    final databaseMapper = DatabaseMapper();

    final allPokemons = await pokemonDao.selectAllPokemons();

    if (allPokemons.isEmpty) {
      throw Exception('Nenhum Pokémon encontrado no banco de dados.');
    }

    final randomIndex = Random().nextInt(allPokemons.length);
    final randomPokemonEntity = allPokemons[randomIndex];

    return databaseMapper.toPokemon(randomPokemonEntity);
  }

  Future<void> capturePokemon(Pokemon pokemon) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('pokemon_database.db').build();
    final equipeDao = database.equipeDao; // Obter o EquipeDao

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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pokémon capturado e salvo na equipe!")),
    );
    Navigator.pop(context); // Voltar para a tela anterior
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encontro Diário"),
      ),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/pokemon_diario.jpg',
            fit: BoxFit.cover, // Ensures the image covers the entire screen
            width: double.infinity,
            height: double.infinity,
          ),
          // Centered content
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
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text("HP: ${pokemon.base['HP'] ?? 0}",
                          style: const TextStyle(color: Colors.white)),
                      Text("Attack: ${pokemon.base['Attack'] ?? 0}",
                          style: const TextStyle(color: Colors.white)),
                      Text("Defense: ${pokemon.base['Defense'] ?? 0}",
                          style: const TextStyle(color: Colors.white)),
                      Text("Sp. Attack: ${pokemon.base['Sp. Attack'] ?? 0}",
                          style: const TextStyle(color: Colors.white)),
                      Text("Sp. Defense: ${pokemon.base['Sp. Defense'] ?? 0}",
                          style: const TextStyle(color: Colors.white)),
                      Text("Speed: ${pokemon.base['Speed'] ?? 0}",
                          style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            text: 'Capturar',
                            onPressed: () {
                              capturePokemon(pokemon);
                            },
                          ),
                          CustomButton(
                            text: 'Fugir',
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
