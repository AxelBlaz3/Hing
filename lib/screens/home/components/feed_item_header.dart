import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/home/components/feed_item_profile.dart';
import 'package:provider/provider.dart';

class FeedItemHeader extends StatefulWidget {
  final Recipe recipe;
  final Function(Recipe newRecipe) refreshCallback;
  const FeedItemHeader(
      {Key? key, required this.recipe, required this.refreshCallback})
      : super(key: key);

  @override
  _FeedItemHeaderState createState() => _FeedItemHeaderState();
}

class _FeedItemHeaderState extends State<FeedItemHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(child: FeedItemProfile(recipe: widget.recipe)),
            IconButton(
                onPressed: () {
                  final RecipeProvider recipeProvider =
                      context.read<RecipeProvider>();
                  widget.recipe.isFavorite
                          ? recipeProvider.removeRecipeFromFavorites(
                              recipeId: widget.recipe.id.oid).then((success) => success
                          ? widget.refreshCallback(widget.recipe..isFavorite = !widget.recipe.isFavorite)
                          : ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Retry'))))
                          : recipeProvider.addRecipeToFavorites(
                              recipeId: widget.recipe.id.oid).then((success) => success
                          ? widget.refreshCallback(widget.recipe..isFavorite = !widget.recipe.isFavorite)
                          : ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Retry'))));
                },
                icon: SvgPicture.asset(widget.recipe.isFavorite
                    ? 'assets/save_filled.svg'
                    : 'assets/save.svg'))
          ],
        ));
  }
}
