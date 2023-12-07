import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationNotifier extends StateNotifier<int> {
  BottomNavigationNotifier({int number = 0}) : super(number);

  void changeIndex({required int newNumber}) {
    state = newNumber;
  }
}

final bottomNavigationProvider = StateNotifierProvider<BottomNavigationNotifier, int>(
    (ref) {
      return BottomNavigationNotifier();
    }
);