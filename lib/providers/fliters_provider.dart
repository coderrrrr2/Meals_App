import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_providers.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.vegetarian: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
        });
  void setFilters(Map<Filter, bool> currentFilters) {
    state = currentFilters;
  }

  void setFilter(Filter filter, bool currentState) {
    state = {...state, filter: currentState};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filterMeals = ref.watch(filterProvider);
  return meals.where((meal) {
    if (filterMeals[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filterMeals[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (filterMeals[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filterMeals[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    return true;
  }).toList();
});
