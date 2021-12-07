import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/ingredient/ingredient.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'components/ingredients_list_item.dart';

class IngredientsListItem1 extends StatefulWidget {
  final Recipe recipe;
  final Ingredient ingredient;
  //final List<String>? myIngredients;
  const IngredientsListItem1(
      {Key? key,
      required this.ingredient,
      //this.myIngredients,
      required this.recipe})
      : super(key: key);

  @override
  State<IngredientsListItem1> createState() => _IngredientsListItemState1();
}

class _IngredientsListItemState1 extends State<IngredientsListItem1> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final UserProvider _userProvider = Provider.of(context, listen: false);
    final isInMyChecklist = (_userProvider.currentUser.myIngredients ?? [])
        .contains(widget.ingredient.name);
    Recipe recipe = widget.recipe;

    return SafeArea(
        top: false,
        child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 144, top: 4),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recipe.ingredients.length,
            itemBuilder: (context, index) => IngredientsListItem(
                recipe: recipe,
                ingredient: recipe.ingredients[index],
                myIngredients: recipe.myIngredients ?? <String>[])));
  }

  void updateMyIngredient(bool isInMyChecklist) async {
    final UserProvider userProvider = context.read<UserProvider>();

    final HingUser user = userProvider.currentUser;

    if (isInMyChecklist) {
      user.myIngredients?.remove(widget.ingredient.name);
    } else {
      if (user.myIngredients == null) {
        user.myIngredients = [widget.ingredient.name];
      } else {
        user.myIngredients?.add(widget.ingredient.name);
      }
    }

    await Hive.box<HingUser>(kUserBox).put(kUserKey,
        user.copy(myIngredients: user.myIngredients?.toSet().toList()));

    // final isUpdated = await userProvider.updateMyIngredients(
    //     recipeId: widget.recipe.id.oid, myIngredients: myIngredients);

    // if (isUpdated) {
    setState(() {});
    // }
  }
}
