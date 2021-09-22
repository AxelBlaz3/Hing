import 'package:flutter/material.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/newrecipe/components/ingredients_item.dart';
import 'package:provider/provider.dart';

class IngredientsList extends StatefulWidget {
  const IngredientsList({Key? key}) : super(key: key);

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
        builder: (_, recipeProvider, __) => ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recipeProvider.ingredients.length,
            separatorBuilder: (_, __) => SizedBox(
                  height: 8,
                ),
            itemBuilder: (_, index) => IngredientsItem(
                  index: index,
                )));
  }
}
