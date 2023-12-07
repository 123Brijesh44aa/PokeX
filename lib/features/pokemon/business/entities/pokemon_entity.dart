import 'package:clean_architecture_by_flutter_mapp/features/pokemon/business/entities/sub_entities.dart';

class PokemonEntity {
  final String name;
  final int id;
  final SpritesEntity sprites;
  final List<TypesEntity> types;

  const PokemonEntity(
      {required this.name,
      required this.id,
      required this.sprites,
      required this.types});
}
