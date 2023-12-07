import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedPokemonItemNotifier extends StateNotifier<int> {
  SelectedPokemonItemNotifier({int number = 0}) : super(number);

  void changeNumber({required int newNumber}) {
    state = newNumber;
  }
}

final selectedPokemonItemProvider =
    StateNotifierProvider<SelectedPokemonItemNotifier, int>((ref) {
  return SelectedPokemonItemNotifier();
});
