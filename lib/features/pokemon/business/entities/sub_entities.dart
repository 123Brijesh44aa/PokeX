class TypeEntity {
  final String name;
  const TypeEntity({required this.name});
}

class TypesEntity {
  final TypeEntity type;
  const TypesEntity({required this.type});
}

class OfficialArtWorkEntity {
  final String frontDefault;
  final String frontShiny;
  const OfficialArtWorkEntity(
      {required this.frontDefault, required this.frontShiny});
}

class OtherEntity {
  final OfficialArtWorkEntity officialArtWork;
  const OtherEntity({required this.officialArtWork});
}

class SpritesEntity {
  final OtherEntity other;
  const SpritesEntity({required this.other});
}
