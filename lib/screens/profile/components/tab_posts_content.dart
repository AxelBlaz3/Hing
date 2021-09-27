import 'package:flutter/material.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/home/components/feed_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ProfileTabPostsContent extends StatefulWidget {
  final HingUser user;
  const ProfileTabPostsContent({Key? key, required this.user})
      : super(key: key);

  @override
  _ProfileTabPostsContentState createState() => _ProfileTabPostsContentState();
}

class _ProfileTabPostsContentState extends State<ProfileTabPostsContent> {
  final int _perPage = 10;
  final PagingController<int, Recipe> _pagingController =
      PagingController<int, Recipe>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    final UserProvider userProvider = Provider.of(context, listen: false);

    _pagingController.addPageRequestListener((pageKey) {
      userProvider.getPosts(page: pageKey, userId: widget.user.id.oid).then((recipes) {
        if (recipes.length < _perPage) {
          _pagingController.appendLastPage(recipes);
        } else {
          _pagingController.appendPage(recipes, pageKey + 1);
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Recipe>(
          itemBuilder: (_, recipe, index) =>
              FeedItem(index: index, recipe: recipe, refreshCallback: (updatedRecipe) {})),
      separatorBuilder: (_, index) => Divider(
        indent: 16.0,
        endIndent: 16.0,
        height: 4,
        color: Theme.of(context).colorScheme.primary.withOpacity(.75),
      ),
    );
  }
}
