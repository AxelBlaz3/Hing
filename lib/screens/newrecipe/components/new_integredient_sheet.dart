import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/ingredient/ingredient.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

class NewIngredientSheet extends StatefulWidget {
  const NewIngredientSheet({Key? key}) : super(key: key);

  @override
  _NewIngredientSheetState createState() => _NewIngredientSheetState();
}

class _NewIngredientSheetState extends State<NewIngredientSheet> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String? unitsValue = getQuantityUnits().first;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _itemController.dispose();
    _quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 24, left: 24, right: 24, top: 32),
        child: SafeArea(
            child: SingleChildScrollView(
                // padding: EdgeInsets.only(
                //     bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).newIngredient,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          controller: _itemController,
                          decoration:
                              InputDecoration(hintText: S.of(context).item),
                          validator: (text) => text == null || text.isEmpty
                              ? S.of(context).ingredientCannotBeEmptyError
                              : null,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _quantityController,
                                validator: (text) => text == null ||
                                        text.isEmpty
                                    ? S.of(context).quantityCannotBeEmptyError
                                    : null,
                                decoration: InputDecoration(
                                    hintText: S.of(context).quantity),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white),
                                  child: Consumer<RecipeProvider>(
                                      builder: (_, recipeProvider, ___) =>
                                          DropdownButton<String>(
                                            underline: SizedBox.shrink(),
                                            isExpanded: true,
                                            value: recipeProvider.quantityUnits,
                                            onChanged: (newUnit) {
                                              recipeProvider.quantityUnits =
                                                  newUnit!;
                                            },
                                            items: getQuantityUnits()
                                                .map((e) =>
                                                    DropdownMenuItem<String>(
                                                      child: Text(e),
                                                      value: e,
                                                    ))
                                                .toList(),
                                          ))),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          S.of(context).newIngredientSummary,
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: OutlinedButton(
                              onPressed: () {
                                final bool isValidated =
                                    _formKey.currentState?.validate() ?? false;

                                if (isValidated) {
                                  final RecipeProvider _recipeProvider =
                                      context.read<RecipeProvider>();

                                  final Ingredient newIngredient = Ingredient(
                                      name: _itemController.text,
                                      quantity: double.parse(
                                          _quantityController.text),
                                      units: _recipeProvider.quantityUnits);

                                  _recipeProvider.addNewIngredient(
                                      ingredient: newIngredient);

                                  _itemController.text = '';
                                  _quantityController.text = '';
                                }
                              },
                              child: Text(S.of(context).addMore),
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16)),
                            )),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      context
                                              .read<RecipeProvider>()
                                              .quantityUnits =
                                          getQuantityUnits().first;
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(S.of(context).done),
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16)))),
                          ],
                        )
                      ],
                    )))));
  }
}
