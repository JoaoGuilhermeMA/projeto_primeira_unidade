import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Certifique-se de ter o pacote flutter_svg importado
import '../../domain/pokemon.dart';
import './type_chip.dart';

class PokemonListItem extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;

  const PokemonListItem({
    required this.pokemon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  Color _getBackgroundColor(String type) {
    switch (type.toLowerCase()) {
      case 'poison':
        return Color(0xFF9F6E97);
      case 'grass':
        return Color(0xFF8BBE8A);
      case 'fire':
        return Color(0xFFFFA756);
      case 'bug':
        return Color(0xFF8BD674);
      case 'electric':
        return Color(0xFFF2CB55);
      case 'ground':
        return Color(0xFFF78551);
      case 'fairy':
        return Color(0xFFEBA8C3);
      case 'flying':
        return Color(0xFF83A2E3);
      case 'water':
        return Color(0xFF58ABF6);
      case 'fighting':
        return Color(0xFFEB4971);
      case 'rock':
        return Color(0xFFD4C294);
      case 'psychic':
        return Color(0xFFFF6568);
      case 'steel':
        return Color(0xFF4C91B2);
      case 'ice':
        return Color(0xFF91D8DF);
      case 'dragon':
        return Color(0xFF7383B9);
      case 'dark':
        return Color(0xFF6F6E78);
      case 'ghost':
        return Color(0xFF8571BE);
      default:
        return Color(0xFFB5B9C4); // Cor padrão
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getBackgroundColor(pokemon.type.first);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16), // Bordas arredondadas
        ),
        child: Stack(
          children: [
            // Imagem de fundo (background)
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/icons/Pokeball.svg', // Caminho para a imagem de fundo
                fit:
                    BoxFit.cover, // Ajuste para cobrir todo o espaço disponível
              ),
            ),
            // Conteúdo em cima da imagem de fundo
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              leading: CachedNetworkImage(
                imageUrl: pokemon.imagem,
                width: 50,
                height: 50,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${pokemon.id}', // Exibe o ID do Pokémon
                    style: TextStyle(
                      color: Colors.black, // Cor preta para o ID
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    pokemon.name, // Nome do Pokémon
                    style: TextStyle(
                      color: Colors.white, // Cor branca para o nome
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              subtitle: Wrap(
                spacing: 8,
                children:
                    pokemon.type.map((type) => TypeChip(type: type)).toList(),
              ),
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
