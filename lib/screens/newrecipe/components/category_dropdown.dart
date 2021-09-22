import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class CategoryDropDown extends StatelessWidget {
  const CategoryDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Consumer<RecipeProvider>(
            builder: (_, recipeProvider, __) => DropdownButton<int>(
                  style: Theme.of(context).textTheme.subtitle2,
                  isExpanded: true,
                  underline: SizedBox(),
                  value: recipeProvider.category,
                  hint: Text(S.of(context).category),
                  items: allCategories
                      .asMap()
                      .entries
                      .map((category) => DropdownMenuItem(
                            child: Text(category.value),
                            value: category.key + 1,
                          ))
                      .toList(),
                  onChanged: (newCategory) {
                    recipeProvider.category = newCategory!;
                  },
                )));
  }
}
