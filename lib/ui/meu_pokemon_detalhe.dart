import 'package:flutter/material.dart';
import 'package:projeto_primeira_unidade/data/database/app_database.dart';
import 'package:projeto_primeira_unidade/data/database/entity/equipe_entity.dart';
import '../domain/pokemon.dart'; // Importa o modelo do Pokémon

class PokemonDetailReleaseScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailReleaseScreen({Key? key, required this.pokemon})
      : super(key: key);

  Future<void> releasePokemon(BuildContext context) async {
    try {
      print("Tentando liberar Pokémon...");
      final database =
          await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final equipeDao = database.equipeDao;

      final equipeEntity = EquipeEntity(pokemonId: pokemon.id);
      await equipeDao.deletePokemonByPokemonId(pokemon.id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pokémon liberado da equipe!")),
      );
      Navigator.pop(context);
    } catch (e) {
      print("Erro ao liberar Pokémon: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Fundo vermelho fora do card
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          '',
          style: TextStyle(color: Colors.white), // Texto em branco
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Título "Detalhes do Pokémon" acima do card
              Text(
                'Detalhes do Pokémon',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Cor branca para o título
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Card com informações do Pokémon
              Container(
                color: Colors.black, // Bordas do card em preto
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: Colors.white, // Fundo do card em branco
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Exibe o nome do Pokémon dentro do card
                        Text(
                          'Nome: ${pokemon.name}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tipos: ${pokemon.type.join(", ")}',
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // Imagem do Pokémon
                        Container(
                          height: 200,
                          color: Colors.white, // Retângulo para a imagem
                          child: Center(
                            child: Image.network(
                              pokemon.imagem,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Atributos do Pokémon
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors
                              .blueGrey[200], // Retângulo para os atributos
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('HP: ${pokemon.base['HP']}',
                                  style: const TextStyle(fontSize: 16)),
                              Text('Ataque: ${pokemon.base['Attack']}',
                                  style: const TextStyle(fontSize: 16)),
                              Text('Defesa: ${pokemon.base['Defense']}',
                                  style: const TextStyle(fontSize: 16)),
                              Text('Sp. Ataque: ${pokemon.base['Sp. Attack']}',
                                  style: const TextStyle(fontSize: 16)),
                              Text('Sp. Defesa: ${pokemon.base['Sp. Defense']}',
                                  style: const TextStyle(fontSize: 16)),
                              Text('Velocidade: ${pokemon.base['Speed']}',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Botão de liberar Pokémon
                        Container(
                          color:
                              Colors.pinkAccent, // Retângulo rosa para o botão
                          child: TextButton.icon(
                            onPressed: () {
                              releasePokemon(context);
                            },
                            icon: const Icon(Icons.free_breakfast,
                                color: Colors.white),
                            label: const Text('Liberar',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
