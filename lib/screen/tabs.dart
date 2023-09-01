import 'package:flutter/material.dart';
import 'package:meals_app/providers/favourite_provider.dart';
import 'package:meals_app/screen/categories.dart';
import 'package:meals_app/screen/filters.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'meals_screen.dart';
import '../providers/fliters_provider.dart';

const kInitialValues = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedIndex = 0;

//set index for the
  void setIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

//favourites meal list

  void setCurrentScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "Filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const FiltersScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget selectedScreen = CategoriesScreen(
      availiableMeals: availableMeals,
    );
    String screenTitle = "Categories";

    if (selectedIndex == 1) {
      final favoritemeals = ref.watch(favouriteMealsProvider);
      selectedScreen = MealScreen(
        title: '',
        meals: favoritemeals,
      );
      screenTitle = "Your favourites";
    }

    return Scaffold(
      drawer: MainDrawer(setScreen: setCurrentScreen),
      appBar: AppBar(
        title: Text(screenTitle),
      ),
      body: selectedScreen,
      bottomNavigationBar: BottomNavigationBar(
          onTap: setIndex,
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites')
          ]),
    );
  }
}
