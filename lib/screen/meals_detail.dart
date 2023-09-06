import 'package:flutter/material.dart';
import 'package:meals_app/providers/favourite_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetail extends ConsumerWidget {
  const MealDetail({
    super.key,
    required this.mealItem,
  });

  final Meal mealItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String steps = "";
    String ingredients = "";
    int index = 1;

    // fomats the meal steps
    mealItem.steps.map((text) {
      steps += "${index++}.  $text\n";
    }).toList();

    //fomats the meal ingredients
    mealItem.ingredients.map((text) {
      ingredients += "$text\n";
    }).toList();
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    final isFavourite = favouriteMeals.contains(mealItem);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favouriteMealsProvider.notifier)
                    .manageFavouriteMealStatusState(mealItem);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        wasAdded ? 'Meal added as Favourite' : 'Meal Removed'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                    child: child,
                  );
                },
                child: Icon(
                  isFavourite ? Icons.star : Icons.star_border,
                  key: ValueKey(isFavourite),
                ),
              ))
        ],
        title: Text(
          mealItem.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: mealItem.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(mealItem.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text("Ingredients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 8,
            ),
            Text(
              ingredients,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
            Text("Steps",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                steps,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
