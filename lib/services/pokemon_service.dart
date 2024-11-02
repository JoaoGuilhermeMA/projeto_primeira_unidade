import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  final String baseUrl;

  PokemonService(this.baseUrl);

  Future<List<Pokemon>> fetchPokemons() async {
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == HttpStatus.ok) {
        final List<dynamic> data = jsonDecode(res.body);
        return data.map((json) => Pokemon.fromJson(json)).toList();
      } else {
        throw 'Erro de conexão: ${res.statusCode}';
      }
    } catch (error) {
      print('Erro ao pegar pokémons: $error');
      throw error;
    }
  }
}
