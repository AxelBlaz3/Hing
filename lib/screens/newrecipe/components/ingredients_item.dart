import 'package:flutter/material.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

class IngredientsItem extends StatefulWidget {
  final int index;
  const IngredientsItem({Key? key, required this.index}) : super(key: key);

  @override
  _IngredientsItemState createState() => _IngredientsItemState();
}

class _IngredientsItemState extends State<IngredientsItem> {
  @override
  Widget build(BuildContext context) {
    final RecipeProvider _recipeProvider = Provider.of(context, listen: false);

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(left: 16),
        child: Row(
          children: [
            Expanded(
                flex: 7,
                child: RichText(
                  text: TextSpan(
                      text: _recipeProvider.ingredients[widget.index].name,
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        TextSpan(
                            style: Theme.of(context).textTheme.caption,
                            text:
                                ' (${_recipeProvider.ingredients[widget.index].quantity} ${_recipeProvider.ingredients[widget.index].units})')
                      ]),
                )),
            SizedBox(
              width: 16,
            ),
            IconButton(
                onPressed: () {
                  final RecipeProvider _recipeProvider =
                      context.read<RecipeProvider>();

                  if (_recipeProvider.ingredients.isNotEmpty) {
                    _recipeProvider.removeIngredient(widget.index);
                  }
                },
                icon: Icon(
                  Icons.remove_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                )),
          ],
        ));
  }
}
