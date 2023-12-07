import 'package:flutter_riverpod/flutter_riverpod.dart';

class  IsPokemonLoadedNotifier extends StateNotifier<bool> {
  IsPokemonLoadedNotifier({bool isPokemonLoaded = false}) : super(isPokemonLoaded);

  void setPokemonLoaded() {
    state = true;
  }
}

final isPokemonLoadedProvider = StateNotifierProvider<IsPokemonLoadedNotifier,bool>(
    (ref) {
      return IsPokemonLoadedNotifier();
    }
);