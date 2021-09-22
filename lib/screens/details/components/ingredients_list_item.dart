import 'package:flutter/material.dart';
import 'package:hing/models/ingredient/ingredient.dart';

class IngredientsListItem extends StatelessWidget {
  final Ingredient ingredient;
  const IngredientsListItem({Key? key, required this.ingredient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: '• ${ingredient.name}',
            style: Theme.of(context).textTheme.bodyText2,
            children: <TextSpan>[
          TextSpan(
              text: ' (${ingredient.quantity} ${ingredient.units})',
              style: Theme.of(context).textTheme.caption)
        ]));
  }
}
