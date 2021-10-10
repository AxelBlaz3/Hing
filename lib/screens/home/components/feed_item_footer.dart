import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/home/components/feed_action_item.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class FeedItemFooter extends StatefulWidget {
  final Recipe recipe;
  final Function(Recipe recipe) refreshCallback;
  final Function(Recipe recipe)? detailsCallback;
  const FeedItemFooter(
      {Key? key,
      required this.recipe,
      required this.refreshCallback,
      this.detailsCallback})
      : super(key: key);

  @override
  _FeedItemFooterState createState() => _FeedItemFooterState();
}

class _FeedItemFooterState extends State<FeedItemFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FeedActionItem(
          recipe: widget.recipe,
          iconPath: widget.recipe.isLiked!
              ? 'assets/star_filled.svg'
              : 'assets/star.svg',
          countLabel: widget.recipe.likesCount > 0
              ? S.of(context).xLikes(widget.recipe.likesCount)
              : S.of(context).like,
          onPressed: () {
            final RecipeProvider recipeProvider =
                context.read<RecipeProvider>();

            !widget.recipe.isLiked!
                ? recipeProvider
                    .likeRecipe(recipeId: widget.recipe.id.oid)
                    .then((success) {
                    if (success) {
                      final Recipe updatedRecipe = widget.recipe
                        ..isLiked = !widget.recipe.isLiked!
                        ..likesCount = widget.recipe.likesCount + 1;
                      widget.refreshCallback(updatedRecipe);
                      if (widget.detailsCallback != null) {
                        widget.detailsCallback!(updatedRecipe);
                      }
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Retry')));
                    }
                  })
                : recipeProvider
                    .unLikeRecipe(recipeId: widget.recipe.id.oid)
                    .then((success) {
                    if (success) {
                      final Recipe updatedRecipe = widget.recipe
                        ..isLiked = !widget.recipe.isLiked!
                        ..likesCount = widget.recipe.likesCount - 1;
                      widget.refreshCallback(updatedRecipe);
                      if (widget.detailsCallback != null) {
                        widget.detailsCallback!(updatedRecipe);
                      }
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Retry')));
                    }
                  });
            //Navigator.of(context).pushNamed(kCommentsRoute);
          },
        )),
        Expanded(
            child: FeedActionItem(
          recipe: widget.recipe,
          iconPath: 'assets/message.svg',
          countLabel: widget.recipe.commentsCount > 0
              ? S.of(context).xComments(widget.recipe.commentsCount)
              : S.of(context).comment,
          onPressed: () {
            Navigator.of(context).pushNamed(kCommentsRoute, arguments: {
              'recipe': widget.recipe,
              'refresh_callback': widget.refreshCallback,
              'details_callback': widget.detailsCallback
            });
          },
        )),
        Expanded(
            child: FeedActionItem(
          recipe: widget.recipe,
          iconPath: 'assets/share.svg',
          countLabel: S.of(context).share,
          onPressed: () async {
            // Navigator.of(context).pushNamed(kCommentsRoute);
            // await context.read<RecipeProvider>().shareRecipe(context, widget.recipe);

            final RecipeProvider recipeProvider =
                context.read<RecipeProvider>();

            final ShortDynamicLink recipeLink = (await recipeProvider
                .getDynamicLinkForShare(recipe: widget.recipe)
                .buildShortLink());

            await Share.share(recipeLink.shortUrl.toString());
          },
        )),
      ],
    );
  }
}
