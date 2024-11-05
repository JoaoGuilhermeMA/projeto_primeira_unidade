import 'package:flutter/material.dart';
import '../data/database/app_database.dart';
import '../data/database/dao/equipe_dao.dart';
import '../data/database/entity/equipe_entity.dart';
import '../data/database/dao/pokemon_dao.dart'; // Importar o PokemonDao
import '../data/database/database_mapper.dart'; // Importar o mapeador, se necessário
import '../domain/pokemon.dart'; // Importar o modelo Pokémon
import '../ui/widget/button_widget.dart';
import '../ui/widget/type_chip.dart'; // Importe o TypeChip

class PokemonDetailReleaseScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailReleaseScreen({Key? key, required this.pokemon})
      : super(key: key);

  Future<void> releasePokemon(BuildContext context) async {
    try {
      print("Tentando liberar Pokémon...");
      final database = await $FloorAppDatabase
          .databaseBuilder('pokemon_database.db')
          .build();
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
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Tipos:', style: TextStyle(fontSize: 18)),
                Wrap(
                  spacing: 8.0,
                  children: pokemon.type
                      .map((type) =>
                          TypeChip(type: type)) // Usa o TypeChip para cada tipo
                      .toList(),
                ),
                const SizedBox(height: 8),
                const Text('Imagem:', style: TextStyle(fontSize: 18)),
                Image.network(pokemon.imagem),
                const SizedBox(height: 8),
                const Text('Atributos:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Liberar',
                  onPressed: () {
                    releasePokemon(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
