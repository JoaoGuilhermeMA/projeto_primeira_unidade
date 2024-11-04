import 'package:floor/floor.dart';

@Entity(tableName: 'equipe')
class EquipeEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int pokemonId;

  EquipeEntity({this.id, required this.pokemonId});
}
