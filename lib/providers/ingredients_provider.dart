import 'package:flutter/material.dart';

class IngredientsProvider with ChangeNotifier {
  int selectedIngredents = 0;

  updateProvider({required int updatedIngredients}) {
    selectedIngredents = updatedIngredients;
    notifyListeners();
  }
}
