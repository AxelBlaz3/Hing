import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/home/components/feed_item_footer.dart';
import 'package:hing/screens/home/components/feed_item_header.dart';
import 'package:provider/provider.dart';
import 'feed_item_body.dart';

class FeedItem extends StatefulWidget {
  final int index;
  final Recipe recipe;
  final bool? fromProfilePage;
  final Function(Recipe newRecipe, {bool shouldRefresh}) refreshCallback;

  FeedItem(
      {Key? key,
      required this.index,
      required this.recipe,
      this.fromProfilePage,
      required this.refreshCallback})
      : super(key: key);

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final isReportedRecipe = (userProvider.currentUser.reportedRecipeIds ?? [])
        .contains(widget.recipe.id.oid);
    return isReportedRecipe
        ? SizedBox()
        : InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(kDetailsRoute, arguments: {
                'index': widget.index,
                'recipe': widget.recipe,
                "fromProfile": widget.fromProfilePage,
                'refresh_callback': widget.refreshCallback
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FeedItemHeader(
                    recipe: widget.recipe,
                    fromProfile: widget.fromProfilePage,
                    refreshCallback: widget.refreshCallback),
                FeedItemBody(index: widget.index, recipe: widget.recipe),
                FeedItemFooter(
                  recipe: widget.recipe,
                  refreshCallback: widget.refreshCallback,
                )
              ],
            ));
  }
}
