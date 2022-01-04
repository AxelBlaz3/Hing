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
import 'package:hing/screens/components/toque_loading.dart';
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
  int wordsRemaining = 500;

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
              color: Theme.of(context).textTheme.headline6!.color,
            ),
            title: Text(
              S.of(context).createARecipe,
              style: Theme.of(context).textTheme.headline6,
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
                          textInputAction: TextInputAction.done,
                          onChanged: (description) {
                            wordsRemaining = 500;
                            List<String> words = description.split(" ");
                            setState(() {
                              wordsRemaining = wordsRemaining - words.length;
                            });
                          },
                          maxLines: null,
                          minLines: 3,
                          validator: (text) => text == null || text.isEmpty
                              ? 'Description cannot be empty'
                              : null,
                          decoration: InputDecoration(
                            counterText: "$wordsRemaining",
                            hintText: 'Description',
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(fontWeight: FontWeight.w100),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).ingredients,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    "Add ingredients",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ]),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    kPrimaryColor,
                                  ),
                                  shape:
                                      MaterialStateProperty.all(CircleBorder()),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(48))),
                                      builder: (_) => NewIngredientSheet());
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        IngredientsList(),
                        SizedBox(height: 16.0),
                        Consumer<RecipeProvider>(
                            builder: (context, recipeProvider, child) =>
                                ElevatedButton(
                                  onPressed: !isValidated ||
                                          (recipeProvider.pickedImage == null &&
                                              recipeProvider.pickedVideo ==
                                                  null)
                                      ? null
                                      : () async {
                                          final recipe = {
                                            "date": DateTime.now(),
                                            'title': _titleController.text,
                                            'description':
                                                _descriptionController.text,
                                            'category': recipeProvider.category,
                                            'user_id':
                                                Hive.box<HingUser>(kUserBox)
                                                    .get(kUserKey)
                                                    ?.id
                                                    .oid,
                                            'ingredients': jsonEncode(
                                                recipeProvider.ingredients)
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
                                                          const ToqueLoading())),
                                              backgroundColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              24))));

                                          final isRecipeCreated =
                                              await recipeProvider.createRecipe(
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

                                          // Clean up picked images/videos and ingredients if any.
                                          recipeProvider.pickedImage = null;
                                          recipeProvider.setPickedVideo(null);
                                          recipeProvider.ingredients.clear();

                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  kHomeRoute, (route) => false);
                                        },
                                  child: Text(S.of(context).publish),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width, 48),
                                  ),
                                )),
                        SizedBox(height: 16.0),
                      ],
                    )),
              ),
            ]),
          ),
        ));
  }
}
