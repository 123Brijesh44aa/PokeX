import 'package:clean_architecture_by_flutter_mapp/core/errors/exceptions.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/business/repositories/pokemon_repository.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../business/entities/pokemon_entity.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final PokemonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure,PokemonEntity>> getPokemon({required PokemonParams params}) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePokemon = await remoteDataSource.getPokemon(params: params);
        localDataSource.cachePokemon(remotePokemon);
        Logger().i(
            " Name : ${remotePokemon.name}, ID : ${remotePokemon.id}, FrontShiny :  ${remotePokemon.sprites.other.officialArtWork.frontShiny}, FrontDefault : ${remotePokemon.sprites.other.officialArtWork.frontDefault}, Types :   ${remotePokemon.types}");
        return Right(remotePokemon);
      } catch (e) {
        Logger().i("$e ............. 🔥🍀⤵️👌👋");
        return Left(ServerFailure(errorMessage: 'this is server exception'));
      }
    } else {
      try {
        final localPokemon = await localDataSource.getLastPokemon();
        return Right(localPokemon);
      } catch (e) {
        return Left(CacheFailure(errorMessage: "No local data found"));
      }
    }
  }
}
