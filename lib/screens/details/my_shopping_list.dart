import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/theme/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class IngredientsListItem1 extends StatefulWidget {
  final Recipe recipe;

  const IngredientsListItem1({Key? key, required this.recipe})
      : super(key: key);

  @override
  State<IngredientsListItem1> createState() => _IngredientsListItemState1();
}

class _IngredientsListItemState1 extends State<IngredientsListItem1> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final UserProvider _userProvider = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: kOnSurfaceColor,
        ),
        title: Text(
          "Shopping List",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: widget.recipe.ingredients.isEmpty
          ? Center(
              child: Text("No ingredients were added !",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: kOnSurfaceColor)),
            )
          : ListView.builder(
              padding: EdgeInsets.only(left: 16, right: 16),
              itemCount: widget.recipe.ingredients.length,
              itemBuilder: (context, int index) {
                final isInMyChecklist =
                    (_userProvider.currentUser.myIngredients ?? [])
                        .contains(widget.recipe.ingredients[index].name);
                return InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 300),
                        content: isInMyChecklist
                            ? Text("Item removed from Shopping List")
                            : Text("Item added to Shopping List")));
                    updateMyIngredient(isInMyChecklist, index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12.0,
                          backgroundColor: isInMyChecklist
                              ? themeData.colorScheme.primary
                              : Colors.grey,
                          child: SvgPicture.asset('assets/check.svg',
                              height: 10.0),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        RichText(
                          text: TextSpan(
                            text: '${widget.recipe.ingredients[index].name}',
                            style: themeData.textTheme.bodyText1,
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      ' (${widget.recipe.ingredients[index].quantity} ${widget.recipe.ingredients[index].units})',
                                  style: themeData.textTheme.caption)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void updateMyIngredient(bool isInMyChecklist, int index) async {
    final UserProvider userProvider = context.read<UserProvider>();
    final HingUser user = userProvider.currentUser;

    if (isInMyChecklist) {
      user.myIngredients?.remove(widget.recipe.ingredients[index].name);
    } else {
      if (user.myIngredients == null) {
        user.myIngredients = [widget.recipe.ingredients[index].name];
      } else {
        user.myIngredients?.add(widget.recipe.ingredients[index].name);
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
