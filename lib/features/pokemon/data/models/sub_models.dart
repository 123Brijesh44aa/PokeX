import 'package:clean_architecture_by_flutter_mapp/features/pokemon/business/entities/sub_entities.dart';

import '../../../../core/constants/constants.dart';

// Types ...............................................

class TypeModel extends TypeEntity {
  const TypeModel({
    required String name,
  }) : super(name: name);

  static TypeModel fromJson(Map<String, dynamic> json) {
    return TypeModel(
      name: json[kType],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kName: name,
    };
  }
}

class TypesModel extends TypesEntity {
  const TypesModel({
    required TypeModel type,
  }) : super(type: type);

  static List<TypesModel> fromJson(List<dynamic> jsonList) {
    List<TypesModel> returnedList = [];
    for (Map<String, dynamic> json in jsonList) {
      returnedList.add(TypesModel(
        type: TypeModel.fromJson(json[kType]),
      ));
    }
    return returnedList;
  }

  Map<String, dynamic> toJson() {
    return {
      kType: type,
    };
  }
}
// ...........................................

class OfficialArtworkModel extends OfficialArtWorkEntity {
  const OfficialArtworkModel(
      {required String frontDefault, required String frontShiny})
      : super(frontDefault: frontDefault, frontShiny: frontShiny);

  static OfficialArtworkModel fromJson(Map<String, dynamic> json) {
    return OfficialArtworkModel(
        frontDefault: json[kFrontDefault], frontShiny: json[kFrontShiny]);
  }

  Map<String, dynamic> toJson() {
    return {kFrontDefault: kFrontDefault, kFrontShiny: frontShiny};
  }
}

class OtherModel extends OtherEntity {
  const OtherModel({required OfficialArtworkModel officialArtworkModel})
      : super(officialArtWork: officialArtworkModel);

  static OtherModel fromJson(Map<String, dynamic> json) {
    return OtherModel(
      officialArtworkModel:
          OfficialArtworkModel.fromJson(json[kOfficialArtwork]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kOfficialArtwork: officialArtWork,
    };
  }
}

// ..................................................... . . .. . . ... .. .  .. . . ..     .  .. . . .. . .

// Sprites !!!!!
class SpritesModel extends SpritesEntity {
  const SpritesModel({required OtherModel other}) : super(other: other);

  static SpritesModel fromJson(Map<String, dynamic> json) {
    return SpritesModel(
      other: OtherModel.fromJson(json[kOther]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kOther: other,
    };
  }
}
