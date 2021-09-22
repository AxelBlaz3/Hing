import 'package:flutter/material.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/repository/recipe_repository.dart';

class FeedProvider extends ChangeNotifier {
  final RecipeRepository recipeRepository;
  List<Recipe> _allRecipes = <Recipe>[];

  FeedProvider({required this.recipeRepository});

  List<Recipe> get allRecipes => _allRecipes;

  Future<List<Recipe>> getRecipesForCategory(
      {int page = 1, int category = 0}) async {
    final recipes = await recipeRepository.getFeedForCategory(
        category: category, page: page);
    this._allRecipes
      ..clear()
      ..addAll(recipes);

    return recipes;
  }
}
