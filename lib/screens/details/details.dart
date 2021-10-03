import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/details/components/details_author_header.dart';
import 'package:hing/screens/details/components/ingredients_list_item.dart';
import 'package:hing/screens/home/components/feed_item_footer.dart';
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
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Recipe recipe = data['recipe'];
    final int index = data['index'];
    final Function(Recipe recipe) refreshCallback = data['refresh_callback'];

    return Scaffold(
        body: DefaultTabController(
            length: 2,
            child: Stack(
              children: [
                SafeArea(
                    top: false,
                    child: CustomScrollView(
                      slivers: [
                        DetailsAppBar(
                          index: index,
                          recipe: recipe,
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
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(.1)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      child: Text(
                                        getAllCategories(
                                            context)[recipe.category - 1],
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline,
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
                              Text(
                                S.of(context).ingredients,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SafeArea(
                                  top: false,
                                  child: ListView.builder(
                                      padding: const EdgeInsets.only(
                                          bottom: 144, top: 16),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: recipe.ingredients.length,
                                      itemBuilder: (context, index) =>
                                          IngredientsListItem(
                                              ingredient:
                                                  recipe.ingredients[index])))
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
                                      builder: (context, recipeProvider,
                                              child) =>
                                          FeedItemFooter(
                                            recipe: data['recipe'],
                                            refreshCallback: refreshCallback,
                                            detailsCallback: (updatedRecipe) {
                                              recipe = updatedRecipe;
                                              recipeProvider
                                                  .notifyRecipeChanges();
                                            },
                                          )),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          final RecipeProvider recipeProvider =
                                              context.read<RecipeProvider>();
                                          if (!recipe.isFavorite) {
                                            recipeProvider
                                                .addRecipeToFavorites(
                                                    recipeId: recipe.id.oid)
                                                .then((success) {
                                              if (success) {
                                                refreshCallback(recipe
                                                  ..isFavorite =
                                                      !recipe.isFavorite);

                                                context
                                                    .read<RecipeProvider>()
                                                    .notifyRecipeChanges();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(S
                                                            .of(context)
                                                            .somethingWentWrong)));
                                              }
                                            });
                                          } else {
                                            recipeProvider
                                                .removeRecipeFromFavorites(
                                                    recipeId: recipe.id.oid)
                                                .then((success) {
                                              if (success) {
                                                refreshCallback(recipe
                                                  ..isFavorite =
                                                      !recipe.isFavorite);

                                                context
                                                    .read<RecipeProvider>()
                                                    .notifyRecipeChanges();
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(S
                                                            .of(context)
                                                            .somethingWentWrong)));
                                              }
                                            });
                                          }
                                        },
                                        child: Consumer<RecipeProvider>(
                                            builder: (context, recipeProvider,
                                                    child) =>
                                                Text(recipe.isFavorite
                                                    ? S
                                                        .of(context)
                                                        .removeFromFavorites
                                                    : S
                                                        .of(context)
                                                        .addToFavorite)),
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 24),
                                            minimumSize:
                                                Size(double.infinity, 48))),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  )
                                ]))))
              ],
            )));
  }
}
