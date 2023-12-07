import 'package:clean_architecture_by_flutter_mapp/core/connection/network_info.dart';
import 'package:clean_architecture_by_flutter_mapp/core/errors/exceptions.dart';
import 'package:clean_architecture_by_flutter_mapp/core/errors/failure.dart';
import 'package:clean_architecture_by_flutter_mapp/core/params/params.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/business/entities/pokemon_entity.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/business/usecases/get_pokemon.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/data/datasources/pokemon_local_data_source.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "package:flutter/foundation.dart";

final pokemonProvider = StateNotifierProvider<PokemonNotifier, PokemonState>(
  (ref) => PokemonNotifier(),
);

@immutable
abstract class PokemonState {}

class InitialPokemonState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final PokemonEntity pokemon;
  PokemonLoadedState({required this.pokemon});
}

class PokemonErrorState extends PokemonState {
  final String message;
  PokemonErrorState({required this.message});
}

class PokemonNotifier extends StateNotifier<PokemonState> {
  PokemonNotifier() : super(InitialPokemonState());

  void eitherFailureOrPokemon({required String value}) async {
    state = PokemonLoadingState();
    try{

    PokemonRepositoryImpl repository = PokemonRepositoryImpl(
        remoteDataSource: PokemonRemoteDataSourceImpl(),
        localDataSource: PokemonLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        networkInfo: NetworkInfoImpl(DataConnectionChecker()));

    final failureOrPokemon =
    await GetPokemon(repository).call(params: PokemonParams(id: value));

    state = failureOrPokemon.fold(
          (failure) => PokemonErrorState(message: failure.toString()),
          (pokemon) => PokemonLoadedState(pokemon: pokemon),
    );
    }
  catch(e) {
      Logger().i(e);
      state = PokemonErrorState(message: e.toString());
  }
  }
}
