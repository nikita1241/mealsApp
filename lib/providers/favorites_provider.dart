import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';

//complex provider for data that can change-end name with Notifier and extend with Statenotifier
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]); //initial data/empty list  passed to StateNotifier<List<Meal>>

//add meal to fav if not already fav n remove otherwise
  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal); //whether a meal fav or not

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false; //item removed //where-filter n get new list 
    } else {
      state = [...state, meal]; //item added //if not fav, add to fav
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});