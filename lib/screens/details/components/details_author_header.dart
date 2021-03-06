import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/home/components/feed_item_profile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class DetailsAuthorHeader extends StatefulWidget {
  final Recipe recipe;
  DetailsAuthorHeader({Key? key, required this.recipe}) : super(key: key);

  @override
  _DetailsAuthorHeaderState createState() => _DetailsAuthorHeaderState();
}

class _DetailsAuthorHeaderState extends State<DetailsAuthorHeader> {
  late Recipe recipe;
  late HingUser? user;

  @override
  void initState() {
    super.initState();

    recipe = widget.recipe;
    user = Hive.box<HingUser>(kUserBox).get(kUserKey);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Expanded(
                child: FeedItemProfile(
                    recipe: widget.recipe, isDetailScreen: true)),

            if (user!.id.oid != recipe.user.id.oid) 
              Consumer<RecipeProvider>(
                  builder: (_, recipeProvider, __) => widget
                          .recipe.user.isFollowing!
                      ? OutlinedButton(
                          onPressed: () async {
                            final bool isUnfollowed = await context
                                .read<UserProvider>()
                                .unFollowUser(
                                    followeeId: widget.recipe.user.id.oid);

                            if (isUnfollowed) {
                              recipe = recipe
                                ..user.isFollowing = !recipe.user.isFollowing!;
                              context
                                  .read<RecipeProvider>()
                                  .notifyRecipeChanges();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Retry')));
                            }
                          },
                          child: Text(
                            S.of(context).unfollow,
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            final bool isFollowed = await context
                                .read<UserProvider>()
                                .followUser(
                                    followeeId: widget.recipe.user.id.oid);

                            if (isFollowed) {
                              recipe = recipe
                                ..user.isFollowing = !recipe.user.isFollowing!;

                              context
                                  .read<RecipeProvider>()
                                  .notifyRecipeChanges();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Retry')));
                            }
                          },
                          child: Text(
                            S.of(context).follow,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                          ),
                        ))
          ],
        ));
  }
}
