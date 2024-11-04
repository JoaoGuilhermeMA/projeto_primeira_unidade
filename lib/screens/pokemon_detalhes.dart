import 'package:flutter/material.dart';
import '../domain/pokemon.dart'; // Certifique-se de importar a classe Pokemon

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon; // Altere para Pokemon

  const PokemonDetailScreen({Key? key, required this.pokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${pokemon.name}',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Tipos: ${pokemon.type.join(', ')}',
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text('Imagem:', style: TextStyle(fontSize: 18)),
                Image.network(pokemon.imagem),
                SizedBox(height: 8),
                Text('Atributos:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('HP: ${pokemon.base['HP']}',
                    style: TextStyle(fontSize: 16)),
                Text('Ataque: ${pokemon.base['Attack']}',
                    style: TextStyle(fontSize: 16)),
                Text('Defesa: ${pokemon.base['Defense']}',
                    style: TextStyle(fontSize: 16)),
                Text('Sp. Ataque: ${pokemon.base['Sp. Attack']}',
                    style: TextStyle(fontSize: 16)),
                Text('Sp. Defesa: ${pokemon.base['Sp. Defense']}',
                    style: TextStyle(fontSize: 16)),
                Text('Velocidade: ${pokemon.base['Speed']}',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
