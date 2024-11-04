class Pokemon {
  final int id;
  final String name;
  final List<String> type; // Lista de tipos
  final Map<String, int> base; // Mapa de estatísticas
  final String imagem;

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
    required this.imagem,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      type: List<String>.from(json['type']), // Ou como necessário
      base: Map<String, int>.from(json['base']), // Ou como necessário
      imagem: json['imagem'], // Ou o que for apropriado
    );
  }
}
