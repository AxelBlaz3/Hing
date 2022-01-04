import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/home/components/feed_item_profile.dart';
import 'package:hing/theme/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class FeedItemHeader extends StatefulWidget {
  final Recipe recipe;
  bool? fromProfile = false;
  final Function(Recipe newRecipe, {bool shouldRefresh}) refreshCallback;

  FeedItemHeader(
      {Key? key,
      required this.recipe,
      this.fromProfile,
      required this.refreshCallback})
      : super(key: key);

  @override
  _FeedItemHeaderState createState() => _FeedItemHeaderState();
}

class _FeedItemHeaderState extends State<FeedItemHeader> {
  @override
  Widget build(BuildContext context) {
    final user = Hive.box<HingUser>(kUserBox).get(kUserKey);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      final cachedUser =
                          Hive.box<HingUser>(kUserBox).get(kUserKey);

                      if (cachedUser!.id.oid == widget.recipe.user.id.oid) {
                        // My Profile.

                        if (!widget.fromProfile!)
                          Navigator.of(context).pushNamed(kMyProfileRoute,
                              arguments: cachedUser);
                      } else {
                        // User profile.
                        if (!widget.fromProfile!)
                          Navigator.of(context).pushNamed(kProfileRoute,
                              arguments: widget.recipe.user);
                      }
                    },
                    child: FeedItemProfile(recipe: widget.recipe))),
            IconButton(
                padding: EdgeInsets.all(0.0),
                onPressed: () {
                  final RecipeProvider recipeProvider =
                      context.read<RecipeProvider>();
                  widget.recipe.isFavorite
                      ? recipeProvider
                          .removeRecipeFromFavorites(
                              recipeId: widget.recipe.id.oid)
                          .then((success) => success
                              ? widget.refreshCallback(widget.recipe
                                ..isFavorite = !widget.recipe.isFavorite)
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Retry'))))
                      : recipeProvider
                          .addRecipeToFavorites(recipeId: widget.recipe.id.oid)
                          .then((success) => success
                              ? widget.refreshCallback(widget.recipe
                                ..isFavorite = !widget.recipe.isFavorite)
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Retry'))));
                },
                icon: SvgPicture.asset(
                    widget.recipe.isFavorite
                        ? 'assets/save_filled.svg'
                        : 'assets/save.svg',
                    height: 18.0,
                    color: Theme.of(context).textTheme.caption!.color)),
            //if current user show delete option
            //else show report user
            widget.recipe.user.id.oid != user!.id.oid
                ? IconButton(
                    onPressed: () {
                      userOptions(context);
                    },
                    padding: EdgeInsets.all(0.0),
                    icon: SvgPicture.asset("assets/report.svg",
                        height: 24.0,
                        color: Theme.of(context).colorScheme.onSurface))
                : IconButton(
                    padding: EdgeInsets.all(0.0),
                    onPressed: () {
                      currentUserOptions(
                          context: context, recipe: widget.recipe);
                    },
                    icon: SvgPicture.asset("assets/report.svg",
                        height: 24.0,
                        color: Theme.of(context).colorScheme.onSurface)),
          ],
        ));
  }

  userOptions(context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        context: (context),
        builder: (BuildContext context) {
          final UserProvider userProvider = context.read<UserProvider>();
          return Container(
              height: 200,
              padding:
                  EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => reportBottomSheet(context),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/report.recipe.svg"),
                          const SizedBox(width: 12.0),
                          Text(
                            "Report",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
                      userProvider
                          .blockUser(
                              userId: user!.id.oid,
                              blockUserId: widget.recipe.user.id.oid)
                          .then((success) {
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("User Blocked")));

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/home", (route) => false);

                          // widget.refreshCallback(widget.recipe,
                          //     shouldRefresh: true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Couldn't block user")));
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: SvgPicture.asset("assets/block.recipe.svg"),
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            "Block",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }

  Future currentUserOptions(
      {required BuildContext context, required Recipe recipe}) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        context: (context),
        builder: (BuildContext context) {
          final UserProvider userProvider = context.read<UserProvider>();
          return Container(
              height: 200,
              padding:
                  EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      await userProvider.deleteUserPost(
                          recipeId: recipe.id.oid, context: context);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: const Icon(Icons.delete_outline_outlined,
                                color: kPrimaryColor),
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            "Delete",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // final user = Hive.box<HingUser>(kUserBox).get(kUserKey);
                      // userProvider
                      //     .blockUser(
                      //         userId: user!.id.oid,
                      //         blockUserId: widget.recipe.user.id.oid)
                      //     .then((success) {
                      //   if (success) {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(content: Text("User Blocked")));

                      //     Navigator.of(context).pushNamedAndRemoveUntil(
                      //         "/home", (route) => false);

                      //     // widget.refreshCallback(widget.recipe,
                      //     //     shouldRefresh: true);
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(content: Text("Couldn't block user")));
                      //   }
                      // });
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Icon(Icons.cancel_outlined,
                                color: kPrimaryColor),
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            "Cancle",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }

  reportBottomSheet(context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 48),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Report",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Why are you reporting this post?",
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 24),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) => TextButton(
                            onPressed: () {
                              final recipeProvider =
                                  Provider.of<RecipeProvider>(context,
                                      listen: false);
                              recipeProvider
                                  .reportRecipe(
                                      reportReason: index == 0
                                          ? "It's Spam"
                                          : index == 1
                                              ? "Eating disorders"
                                              : index == 2
                                                  ? "False Information"
                                                  : index == 3
                                                      ? "Nudity or sexual activity"
                                                      : index == 4
                                                          ? "Intellectual property violation"
                                                          : "",
                                      recipeId: widget.recipe.id.oid)
                                  .then((success) {
                                if (success) {
                                  onReportSent(context, widget.recipe, index);
                                  widget.refreshCallback(widget.recipe,
                                      shouldRefresh: true);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Reported Recipe")));
                                } else {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Could not report recipe")));
                                }
                              });
                            },
                            child: Row(children: [
                              Text(
                                index == 0
                                    ? "It's Spam"
                                    : index == 1
                                        ? "Eating disorders"
                                        : index == 2
                                            ? "False Information"
                                            : index == 3
                                                ? "Nudity or sexual activity"
                                                : index == 4
                                                    ? "Intellectual property violation"
                                                    : "",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ]))),
                  ]));
        });
  }

  void onReportSent(BuildContext context, Recipe recipe, int index) async {
    final UserProvider userProvider = context.read<UserProvider>();
    userProvider.updateReportedRecipes(recipe);

    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 36,
              ),
              SvgPicture.asset("assets/Success_Illustration.svg"),
              Text(
                "Thanks for reporting the post",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Your Feedback is very important. We do not encourage such type of content on this app, Thank you.",
                    style: Theme.of(context).textTheme.subtitle2,
                  )),
              Spacer(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFFEAD1D)),
                          fixedSize: MaterialStateProperty.all(Size(350, 50))),
                      child: Text("DONE"))),
              SizedBox(
                height: 24,
              )
            ],
          );
        });
  }
}
