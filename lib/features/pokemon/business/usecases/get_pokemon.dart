import 'package:clean_architecture_by_flutter_mapp/core/errors/failure.dart';
import 'package:clean_architecture_by_flutter_mapp/core/params/params.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/business/entities/pokemon_entity.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/business/repositories/pokemon_repository.dart';
import 'package:dartz/dartz.dart';

class GetPokemon {

  final PokemonRepository repository;

  GetPokemon(this.repository);

  Future<Either<Failure, PokemonEntity>> call ({required PokemonParams params}) async {
    return await repository.getPokemon(params: params);
  }

  // Future<PokemonEntity> call ({required PokemonParams params}) async {
  //   return await repository.getPokemon(params: params);
  // }
}