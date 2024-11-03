import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required int id,
    required String nameEnglish,
    required String nameJapanese,
    required String nameChinese,
    required String nameFrench,
    required List<String> type,
    required Map<String, int> baseStats,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
}
