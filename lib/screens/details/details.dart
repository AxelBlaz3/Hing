import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/components/loading_screen.dart';
import 'package:hing/screens/details/components/details_author_header.dart';
import 'package:hing/screens/details/components/ingredients_list_item.dart';
import 'package:hing/screens/home/components/feed_item_footer.dart';
import 'package:hing/theme/colors.dart';
import 'package:provider/provider.dart';
import 'components/details_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //final int index = ModalRoute.of(context)?.settings.arguments as int;
    final data = ModalRoute.of(context)!.settings.arguments;
    final RecipeProvider recipeProvider = Provider.of(context, listen: false);

    return Scaffold(
        body: data is String
            ? FutureBuilder<Recipe?>(
                future: recipeProvider.getRecipe(recipeId: data),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const LoadingScreen();
                  } else if (snapshot.data == null || snapshot.hasError) {
                    return Placeholder();
                  }
                  return DetailsScreenReady(
                      refreshCallback: (updatedRecipe) {},
                      recipe: snapshot.data as Recipe,
                      index: 0);
                })
            : DetailsScreenReady(
                index: (data! as Map<String, dynamic>)['index'] as int,
                recipe: (data as Map<String, dynamic>)['recipe'] as Recipe,
                refreshCallback:
                    data['refresh_callback'] as Function(Recipe recipe)));
  }
}

class DetailsScreenReady extends StatefulWidget {
  final int index;
  final Recipe recipe;
  final Function(Recipe recipe) refreshCallback;

  const DetailsScreenReady(
      {Key? key,
      required this.index,
      required this.recipe,
      required this.refreshCallback})
      : super(key: key);

  @override
  _DetailsScreeReadyState createState() => _DetailsScreeReadyState();
}

class _DetailsScreeReadyState extends State<DetailsScreenReady> {
  int ingredientsSelected = 0;
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    Recipe recipe = widget.recipe;
    return Stack(
      children: [
        SafeArea(
            top: false,
            child: CustomScrollView(
              slivers: [
                DetailsAppBar(
                  index: widget.index,
                  recipe: recipe,
                  ingredientsSelected: ingredientsSelected,
                ),
                SliverPadding(
                    padding: EdgeInsets.all(16),
                    sliver: SliverList(
                        delegate: SliverChildListDelegate([
                      DetailsAuthorHeader(recipe: recipe),
                      Text(
                        recipe.title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Text(
                                getAllCategories(context)[recipe.category - 1],
                                style: Theme.of(context).textTheme.overline,
                              )),
                          Expanded(child: SizedBox())
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        S.of(context).description,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        recipe.description,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      RichText(
                        text: TextSpan(
                            text: S.of(context).ingredients,
                            style: Theme.of(context).textTheme.subtitle2,
                            children: [
                              TextSpan(
                                text: ' (Check the one\'s you have)',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ]),
                      ),
                      const SizedBox(height: 8.0),
                      recipe.ingredients.isEmpty
                          ? Text("No ingredient's were added",
                              style: TextStyle(color: kOnSurfaceColor))
                          : SafeArea(
                              top: false,
                              child: ListView.builder(
                                  padding: const EdgeInsets.only(
                                      bottom: 144, top: 4),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: recipe.ingredients.length,
                                  itemBuilder: (context, index) {
                                    return IngredientsListItem(
                                        recipe: recipe,
                                        ingredient: recipe.ingredients[index],
                                        myIngredients:
                                            recipe.myIngredients ?? <String>[]);
                                  }))
                    ])))
              ],
            )),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer<RecipeProvider>(
                      builder: (context, recipeProvider, child) =>
                          FeedItemFooter(
                            recipe: recipe,
                            refreshCallback: widget.refreshCallback,
                            detailsCallback: (updatedRecipe) {
                              recipe = updatedRecipe;
                              recipeProvider.notifyRecipeChanges();
                            },
                          )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                        onPressed: () {
                          final RecipeProvider recipeProvider =
                              context.read<RecipeProvider>();
                          if (!recipe.isFavorite) {
                            recipeProvider
                                .addRecipeToFavorites(recipeId: recipe.id.oid)
                                .then((success) {
                              if (success) {
                                widget.refreshCallback(
                                    recipe..isFavorite = !recipe.isFavorite);

                                context
                                    .read<RecipeProvider>()
                                    .notifyRecipeChanges();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            S.of(context).somethingWentWrong)));
                              }
                            });
                          } else {
                            recipeProvider
                                .removeRecipeFromFavorites(
                                    recipeId: recipe.id.oid)
                                .then((success) {
                              if (success) {
                                widget.refreshCallback(
                                    recipe..isFavorite = !recipe.isFavorite);

                                context
                                    .read<RecipeProvider>()
                                    .notifyRecipeChanges();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            S.of(context).somethingWentWrong)));
                              }
                            });
                          }
                        },
                        child: Consumer<RecipeProvider>(
                            builder: (context, recipeProvider, child) => Text(
                                recipe.isFavorite
                                    ? S.of(context).removeFromFavorites
                                    : S.of(context).addToFavorite)),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            minimumSize: Size(double.infinity, 48))),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
