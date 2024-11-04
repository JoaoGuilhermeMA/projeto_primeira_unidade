import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required int id,
    required String name,
    required List<String> type,
    required Map<String, int> base,
    required String imagem,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] ?? 'Unknown',
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      base: (json['base'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          value is int ? value : int.tryParse(value.toString()) ?? 0,
        ),
      ),
      imagem: json['imagem'] ?? '',
    );
  }
}
