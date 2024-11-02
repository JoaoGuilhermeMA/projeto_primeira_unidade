class Pokemon {
  final int id;
  final String nameEnglish;
  final String nameJapanese;
  final String nameChinese;
  final String nameFrench;
  final List<String> type;
  final Map<String, int> baseStats;

  Pokemon({
    required this.id,
    required this.nameEnglish,
    required this.nameJapanese,
    required this.nameChinese,
    required this.nameFrench,
    required this.type,
    required this.baseStats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      nameEnglish: json['name']['english'],
      nameJapanese: json['name']['japanese'],
      nameChinese: json['name']['chinese'],
      nameFrench: json['name']['french'],
      type: List<String>.from(json['type']),
      baseStats: Map<String, int>.from(json['base']),
    );
  }
}
