import 'package:flutter/material.dart';
import '../domain/pokemon.dart'; // Certifique-se de importar a classe Pokemon
import '../ui/widget/type_chip.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({Key? key, required this.pokemon})
      : super(key: key);

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
                          'Tipos:',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: pokemon.type
                              .map((type) => TypeChip(type: type))
                              .toList(),
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
