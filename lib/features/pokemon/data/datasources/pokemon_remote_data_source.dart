

import 'package:clean_architecture_by_flutter_mapp/core/params/params.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../models/pokemon_model.dart';


abstract class PokemonRemoteDataSource {
  Future<PokemonModel> getPokemon( {required PokemonParams params});
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final Dio dio = Dio();
  PokemonRemoteDataSourceImpl();

  @override
  Future<PokemonModel> getPokemon({required PokemonParams params}) async{
    try {
      Logger().i("https://pokeapi.co/api/v2/pokemon/${params.id}");
      final response = await dio.get(
        "https://pokeapi.co/api/v2/pokemon/${params.id}",
      );

      Logger().i(response.data.toString().substring(0,500));

      if (response.statusCode == 200) {
        Logger().i(response.data.toString().substring(0,1000));
        Logger().i(response.data);
        return PokemonModel.fromJson(response.data);
      }
      else{
        throw Exception();
      }

    } catch(e){
      Logger().i(e.toString());
      throw Exception();
    }
  }
}