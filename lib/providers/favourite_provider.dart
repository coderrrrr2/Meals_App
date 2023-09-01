import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool manageFavouriteMealStatusState(Meal meal) {
    final mealIsFavourite = state.contains(meal);

    if (mealIsFavourite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
