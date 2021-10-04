import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/ingredient/ingredient.dart';
import 'package:hing/repository/recipe_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class RecipeProvider extends ChangeNotifier {
  final RecipeRepository recipeRepository;
  XFile? _pickedImage;
  XFile? _pickedVideo;
  VideoPlayerController? _controller;
  String _units = getQuantityUnits().first;
  int _category = 1;

  RecipeProvider({required this.recipeRepository});

  XFile? get pickedImage => _pickedImage;
  XFile? get pickedVideo => _pickedVideo;
  String get quantityUnits => _units;
  int get category => _category;
  VideoPlayerController? get videoPlayerController => _controller;
  List<Ingredient> _ingredients = <Ingredient>[];

  List<Ingredient> get ingredients => _ingredients;

  set ingredients(List<Ingredient> newIngredients) {
    _ingredients.clear();
    _ingredients.addAll(newIngredients);

    notifyListeners();
  }

  void addNewIngredient({required Ingredient ingredient}) {
    _ingredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(int index) {
    _ingredients.removeAt(index);
    notifyListeners();
  }

  set pickedImage(XFile? newImageFile) {
    _pickedVideo = null;
    _pickedImage = newImageFile;

    notifyListeners();
  }

  set quantityUnits(String newUnits) {
    _units = newUnits;
    notifyListeners();
  }

  set category(int newCategory) {
    _category = newCategory;
    notifyListeners();
  }

  void updateIngredient(int index, String newName, double newQuantity) {
    _ingredients[index] = _ingredients[index]
      ..name = newName
      ..quantity = newQuantity;
  }

  Future<void> setPickedVideo(XFile? newVideoFile) async {
    _pickedImage = null;
    _pickedVideo = newVideoFile;

    if (_pickedVideo != null) {
      VideoPlayerController videoPlayerController =
          VideoPlayerController.file(File(_pickedVideo!.path));
      await videoPlayerController.initialize();
      _controller = videoPlayerController;
      _controller!.play();
      notifyListeners();
    }
  }

  void notifyRecipeChanges() {
    notifyListeners();
  }

  Future<bool> createRecipe({required Map<String, dynamic> recipe}) async {
    return await recipeRepository.createNewRecipe(
        recipe, this._pickedImage ?? this.pickedVideo);
  }

  Future<bool> likeRecipe({required String recipeId}) async {
    return await recipeRepository.likeRecipe(recipeId: recipeId);
  }

  Future<bool> unLikeRecipe({required String recipeId}) async {
    return await recipeRepository.unLikeRecipe(recipeId: recipeId);
  }

  Future<bool> addRecipeToFavorites({required String recipeId}) async {
    return await recipeRepository.addRecipeToFavorites(recipeId: recipeId);
  }

  Future<bool> removeRecipeFromFavorites({required String recipeId}) async {
    return await recipeRepository.removeRecipeFromFavorites(recipeId: recipeId);
  }
}
