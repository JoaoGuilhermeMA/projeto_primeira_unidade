import 'package:dio/dio.dart';
import '../entity/pokemon_entity.dart';
import '../../../exceptions/network_exception.dart';

class PokemonApiClient {
  final Dio _dio;

  PokemonApiClient({required String baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl))
          ..interceptors
              .add(LogInterceptor(requestBody: true, responseBody: true));

  Future<List<PokemonEntity>> fetchPokemons() async {
    final response = await _dio.get("/pokedex");
    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    }
    return (response.data['pokedex'] as List)
        .map((json) => PokemonEntity.fromJson(json))
        .toList();
  }
}
