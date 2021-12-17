import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/components/empty_illustration.dart';
import 'package:hing/screens/home/components/feed_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProfileTabPostsContent extends StatefulWidget {
  final HingUser user;
  final PagingController<int, Recipe> pagingController;
  const ProfileTabPostsContent(
      {Key? key, required this.user, required this.pagingController})
      : super(key: key);

  @override
  _ProfileTabPostsContentState createState() => _ProfileTabPostsContentState();
}

class _ProfileTabPostsContentState extends State<ProfileTabPostsContent> {

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => Future.sync(() => widget.pagingController.refresh()),
        child: PagedListView.separated(
          padding: const EdgeInsets.only(bottom: 72, top: 24),
          pagingController: widget.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Recipe>(
            noItemsFoundIndicatorBuilder: (_) => EmptyIllustration(assetPath: 'assets/no_users_illustration.png', title: S.of(context).noRecipesTitle, summary: S.of(context).noUsersSummary,),
              itemBuilder: (_, recipe, index) => FeedItem(
                  index: index,
                  recipe: recipe,
                  refreshCallback: (updatedRecipe, {bool shouldRefresh = false}) {
                    widget.pagingController.itemList = List.of(
                        widget.pagingController.itemList!
                          ..[index] = updatedRecipe);
                  })),
          separatorBuilder: (_, index) => Divider(
            indent: 16.0,
            endIndent: 16.0,
            height: 4,
            color: Theme.of(context).colorScheme.primary.withOpacity(.75),
          ),
        ));
  }
}
