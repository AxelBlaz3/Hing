import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/profile/components/user_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class SheetRecipeLikes extends StatefulWidget {
  final Recipe recipe;
  const SheetRecipeLikes({Key? key, required this.recipe}) : super(key: key);

  @override
  _SheetRecipeLikesState createState() => _SheetRecipeLikesState();
}

class _SheetRecipeLikesState extends State<SheetRecipeLikes> {
  PagingController<int, HingUser> _pagingController =
      PagingController<int, HingUser>(firstPageKey: 1);
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();

    final recipeProvider = context.read<RecipeProvider>();
    _pagingController.addPageRequestListener((pageKey) {
      recipeProvider
          .getRecipeLikes(recipeId: widget.recipe.id.oid)
          .then((users) {
        if (users.length < _pageSize) {
          _pagingController.appendLastPage(users);
        } else {
          _pagingController.appendPage(users, pageKey + 1);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      const SizedBox(
        height: 16.0,
      ),
      Container(
        height: 4.0,
        width: 72.0,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(24.0)),
      ),
      const SizedBox(
        height: 24.0,
      ),
      Text(
        S.of(context).likes,
        style: Theme.of(context).textTheme.headline5,
      ),
      PagedListView(
          pagingController: _pagingController,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          physics: NeverScrollableScrollPhysics(),
          builderDelegate: PagedChildBuilderDelegate<HingUser>(
              itemBuilder: (context, user, index) => UserItem(
                  user: user,
                  isFollowing: user.isFollowing!,
                  refreshCallback: (user) {
                    _pagingController.itemList =
                        List.of(_pagingController.itemList!..[index] = user);
                  })))
    ]));
  }
}
