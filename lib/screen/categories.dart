import 'package:flutter/material.dart';
import 'package:meals_app/data/data.dart';
import 'package:meals_app/screen/meals_screen.dart';
import 'package:meals_app/widgets/categories_grid_view.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availiableMeals});
  final List<Meal> availiableMeals;

  void selectCategory(BuildContext context, Category category) {
    final newList = availiableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MealScreen(
                title: category.title,
                meals: newList,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20),
        children: [
          for (final category in availableCategories)
            CategoriesGridView(
                category: category,
                onSelectCategoryGridItem: () {
                  selectCategory(context, category);
                })
        ],
      ),
    );
  }
}
