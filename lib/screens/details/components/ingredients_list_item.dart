import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/ingredient/ingredient.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/src/provider.dart';

class IngredientsListItem extends StatefulWidget {
  final Recipe recipe;
  final Ingredient ingredient;
  final List<String> myIngredients;
  const IngredientsListItem(
      {Key? key,
      required this.ingredient,
      required this.myIngredients,
      required this.recipe})
      : super(key: key);

  @override
  State<IngredientsListItem> createState() => _IngredientsListItemState();
}

class _IngredientsListItemState extends State<IngredientsListItem> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final UserProvider _userProvider = Provider.of(context, listen: false);
    final isInMyChecklist = (_userProvider.currentUser.myIngredients ?? [])
        .contains(widget.ingredient.name);

    return InkWell(
        onTap: () {
          updateMyIngredient(isInMyChecklist);
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(children: [
              CircleAvatar(
                radius: 8.0,
                backgroundColor: isInMyChecklist
                    ? themeData.colorScheme.primary
                    : Colors.grey,
                child: SvgPicture.asset('assets/check.svg', height: 10.0),
              ),
              const SizedBox(
                width: 8.0,
              ),
              RichText(
                  text: TextSpan(
                      text: '${widget.ingredient.name}',
                      style: themeData.textTheme.bodyText2,
                      children: <TextSpan>[
                    TextSpan(
                        text:
                            ' (${widget.ingredient.quantity} ${widget.ingredient.units})',
                        style: themeData.textTheme.caption)
                  ]))
            ])));
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

    await Hive.box<HingUser>(kUserBox).put(kUserKey, user.copy(myIngredients: user.myIngredients?.toSet().toList()));

    // final isUpdated = await userProvider.updateMyIngredients(
    //     recipeId: widget.recipe.id.oid, myIngredients: myIngredients);

    // if (isUpdated) {
    setState(() {});
    // }
  }
}
