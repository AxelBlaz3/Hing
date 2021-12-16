import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/home/components/feed_item_profile.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      final cachedUser =
                          Hive.box<HingUser>(kUserBox).get(kUserKey);
                      if (cachedUser!.id.oid == widget.recipe.user.id.oid) {
                        // My Profile.
                        Navigator.of(context)
                            .pushNamed(kMyProfileRoute, arguments: cachedUser);
                      } else {
                        // User profile.
                        Navigator.of(context).pushNamed(kProfileRoute,
                            arguments: widget.recipe.user);
                      }
                    },
                    child: FeedItemProfile(recipe: widget.recipe))),
            IconButton(
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
                    color: Theme.of(context).textTheme.caption!.color)),
            IconButton(
                onPressed: () {
                  threeDotMenu(context);
                },
                icon: SvgPicture.asset("assets/report.svg"))
          ],
        ));
  }

  threeDotMenu(context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        context: (context),
        builder: (BuildContext context) {
          return Container(
              height: 200,
              padding:
                  EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        reportBottomSheet(context);
                      },
                      child: Text(
                        "Report",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Block",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.black),
                      ))
                ],
              ));
        });
  }

  reportBottomSheet(context) {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 24),
              height: 500,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Report",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Why are you reporting this post?",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                recipeProvider.reportRecipe(
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
                                    userId: widget.recipe.user.id.oid,
                                    recipeId: widget.recipe.id.oid);

                                onReportSent(context, widget.recipe, index);
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    )
                                  ]))),
                    ),
                  ]));
        });
  }

  void onReportSent(BuildContext context, Recipe recipe, int index) async {
    final UserProvider userProvider = context.read<UserProvider>();
    userProvider.updateReportedRecipes(recipe);
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        context: context,
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
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    "Your Feedback is very important.We don't encourage such type of content on this app , thank you report ",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: Colors.black),
                  )),
              Spacer(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {
                        recipeProvider.recipeRepository.reportRecipe(
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
                            userId: widget.recipe.id.oid,
                            recipeId: widget.recipe.id.oid);
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
