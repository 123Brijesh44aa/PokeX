import 'package:clean_architecture_by_flutter_mapp/core/errors/failure.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/business/entities/pokemon_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/params/params.dart';

abstract class PokemonRepository {
  Future<Either<Failure,PokemonEntity>> getPokemon({required PokemonParams params});

  // Future<PokemonEntity> getPokemon({required PokemonParams params});
}