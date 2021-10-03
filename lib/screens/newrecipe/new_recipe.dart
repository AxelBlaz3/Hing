import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/newrecipe/components/category_dropdown.dart';
import 'package:hing/screens/newrecipe/components/ingredients_list.dart';
import 'package:hing/screens/newrecipe/components/media_picker.dart';
import 'package:hing/screens/newrecipe/components/new_integredient_sheet.dart';
import 'package:hing/screens/newrecipe/components/preview_media.dart';
import 'package:hing/screens/newrecipe/publishing_sheet.dart';
import 'package:hing/theme/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({Key? key}) : super(key: key);

  @override
  _NewRecipeScreenState createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isValidated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          final RecipeProvider recipeProvider = context.read<RecipeProvider>();
          recipeProvider
            ..ingredients.clear()
            ..setPickedVideo(null)
            ..pickedImage = null;
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: kOnSurfaceColor,
            ),
            title: Text(
              S.of(context).createARecipe,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: kOnSurfaceColor),
            ),
          ),
          body: SafeArea(
            child: Stack(children: [
              SingleChildScrollView(
                padding:
                    EdgeInsets.only(bottom: 96, top: 24, left: 24, right: 24),
                child: Form(
                    key: _formKey,
                    onChanged: () {
                      setState(() {
                        isValidated =
                            _formKey.currentState?.validate() ?? false;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).title),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _titleController,
                          validator: (text) => text == null || text.isEmpty
                              ? 'Recipe name cannot be empty'
                              : null,
                          decoration:
                              InputDecoration(hintText: 'Tasty Recipe Name'),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        PreviewMedia(),
                        SizedBox(
                          height: 16,
                        ),
                        MediaPicker(),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          S.of(context).category,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CategoryDropDown(),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          S.of(context).description,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 3,
                          maxLength: 400,
                          validator: (text) => text == null || text.isEmpty
                              ? 'Description cannot be empty'
                              : null,
                          decoration: InputDecoration(
                            hintText: 'Less than 400 words',
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          S.of(context).ingredients,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        IngredientsList(),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(24))),
                                      builder: (_) => NewIngredientSheet());
                                },
                                child: Text(S.of(context).addItem)))
                      ],
                    )),
              ),
              Container(
                  margin: EdgeInsets.all(24),
                  alignment: Alignment.bottomCenter,
                  child: Hero(
                      tag: 'fab',
                      child: Consumer<RecipeProvider>(
                          builder: (context, recipeProvider, child) =>
                              ElevatedButton(
                                onPressed: !isValidated ||
                                        (recipeProvider.pickedImage == null &&
                                            recipeProvider.pickedVideo ==
                                                null) ||
                                        recipeProvider.ingredients.isEmpty
                                    ? null
                                    : () async {
                                        final RecipeProvider _recipeProvider =
                                            context.read<RecipeProvider>();

                                        if (_recipeProvider
                                            .ingredients.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(S
                                                      .of(context)
                                                      .ingredientsCannotBeEmpty)));
                                          return;
                                        }

                                        final recipe = {
                                          'title': _titleController.text,
                                          'description':
                                              _descriptionController.text,
                                          'category': _recipeProvider.category,
                                          'user_id':
                                              Hive.box<HingUser>(kUserBox)
                                                  .get(kUserKey)
                                                  ?.id
                                                  .oid,
                                          'ingredients': jsonEncode(
                                              _recipeProvider.ingredients)
                                        };

                                        // Show publishing sheet.
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            enableDrag: false,
                                            isDismissible: false,
                                            builder: (_) => SafeArea(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            24),
                                                    child:
                                                        const PublishingSheet())),
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            24))));

                                        final isRecipeCreated =
                                            await _recipeProvider.createRecipe(
                                                recipe: recipe);
                                        if (!isRecipeCreated) {
                                          // Dimiss publishing sheet.
                                          Navigator.of(context).pop();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(S
                                                      .of(context)
                                                      .somethingWentWrong)));
                                          return;
                                        }

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(S
                                                    .of(context)
                                                    .newRecipeCreated)));

                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                kHomeRoute, (route) => false);
                                      },
                                child: Text(S.of(context).publish),
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width, 48)),
                              ))))
            ]),
          ),
        ));
  }
}
