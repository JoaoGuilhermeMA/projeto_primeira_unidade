import 'package:flutter/material.dart';

class TypeChip extends StatelessWidget {
  final String type;

  const TypeChip({Key? key, required this.type}) : super(key: key);

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'poison':
        return Colors.purple; // Cor específica para o tipo Poison
      case 'grass':
        return Colors.green; // Cor para tipo Grass
      case 'fire':
        return Colors.red; // Cor para tipo Fire
      case 'bug':
        return Color.fromRGBO(181, 255, 3, 100);
      case 'electric':
        return Colors.yellow;
      case 'ground':
        return Color.fromRGBO(205, 161, 3, 100);
      case 'fairy':
        return Colors.pinkAccent;
      case 'flying':
        return const Color.fromARGB(228, 96, 231, 255);
      case 'water':
        return Colors.blue;
      case 'fighting':
        return const Color.fromARGB(255, 78, 5, 0);
      case 'rock':
        return const Color.fromARGB(255, 51, 43, 0);
      case 'psychic':
        return const Color.fromARGB(255, 253, 128, 232);
      case 'steel':
        return const Color.fromARGB(255, 71, 71, 71);
      case 'ice':
        return const Color.fromARGB(255, 112, 210, 255);
      case 'dragon':
        return const Color.fromARGB(255, 77, 1, 255);
      case 'dark':
        return const Color.fromARGB(255, 0, 0, 0);
      case 'ghost':
        return const Color.fromARGB(255, 148, 82, 255);
      default:
        return const Color.fromARGB(158, 255, 152, 69); // Cor padrão
    }
  }

  Color _getTextColor(String type) {
    switch (type.toLowerCase()) {
      case 'bug':
        return Colors.white;
      default:
        return Colors.white; // Cor padrão
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getTypeColor(type),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(
          color: _getTextColor(type), // Remova `const` aqui
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
