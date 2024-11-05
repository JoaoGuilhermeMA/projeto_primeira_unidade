import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importar o pacote flutter_svg

class TypeChip extends StatelessWidget {
  final String type;

  const TypeChip({Key? key, required this.type}) : super(key: key);

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'poison':
        return Color(0xFFA552CC);
      case 'grass':
        return Color(0xFF62B957);
      case 'fire':
        return Color(0xFFFD7D24);
      case 'bug':
        return Color(0xFF8CB230);
      case 'electric':
        return Color(0xFFEED535);
      case 'ground':
        return Color(0xFFDD7748);
      case 'fairy':
        return Color(0xFFED6EC7);
      case 'flying':
        return Color(0xFF748FC9);
      case 'water':
        return Color(0xFF4A90DA);
      case 'fighting':
        return Color(0xFFD04164);
      case 'rock':
        return Color(0xFFBAAB82);
      case 'psychic':
        return Color(0xFFEA5D60);
      case 'steel':
        return Color(0xFF417D9A);
      case 'ice':
        return Color(0xFF61CEC0);
      case 'dragon':
        return Color(0xFF0F6AC0);
      case 'dark':
        return Color(0xFF58575F);
      case 'ghost':
        return Color(0xFF556AAE);
      default:
        return Color(0xFF9DA0AA); // Cor padrão
    }
  }

  Color _getTextColor(String type) {
    return Colors.white;
  }

  String _getTypeIconPath(String type) {
    return 'assets/icons/$type.svg'; // Converte o tipo para minúsculas
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getTypeColor(type),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 1, // Ajuste a escala conforme necessário
            child: SvgPicture.asset(
              _getTypeIconPath(type), // Use o caminho do ícone SVG
              width: 16, // Mantenha o tamanho original ou defina para null
              height: 16, // Mantenha o tamanho original ou defina para null
              placeholderBuilder: (BuildContext context) => const SizedBox(
                width: 24,
                height: 24,
                child:
                    CircularProgressIndicator(), // Opcional: placeholder enquanto carrega
              ),
            ),
          ),
          const SizedBox(width: 4), // Espaçamento entre a imagem e o texto
          Text(
            type.toUpperCase(),
            style: TextStyle(
              color: _getTextColor(type),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
