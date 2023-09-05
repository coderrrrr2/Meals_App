import 'package:flutter/material.dart';
import 'package:meals_app/data/data.dart';
import 'package:meals_app/screen/meals_screen.dart';
import 'package:meals_app/widgets/categories_grid_view.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availiableMeals});
  final List<Meal> availiableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 3,
        ),
        lowerBound: 0,
        upperBound: 1);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void selectCategory(BuildContext context, Category category) {
    final newList = widget.availiableMeals.where((meal) {
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
    return AnimatedBuilder(
        animation: animationController,
        child: GridView(
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
        builder: (context, child) => Padding(padding: child));
  }
}
