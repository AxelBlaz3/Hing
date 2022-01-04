import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/components/error_illustration.dart';
import 'package:hing/screens/components/toque_placeholder.dart';
import 'package:hing/screens/home/home.dart';
import 'package:hing/theme/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants.dart';

class DetailsAppBar extends StatefulWidget {
  final int index;
  final Recipe recipe;
  final ingredientsSelected;

  const DetailsAppBar(
      {Key? key,
      required this.index,
      required this.ingredientsSelected,
      required this.recipe})
      : super(key: key);

  @override
  _DetailsAppBarState createState() => _DetailsAppBarState();
}

class _DetailsAppBarState extends State<DetailsAppBar> {
  VideoPlayerController? _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  final HomeScreen homeScreen = HomeScreen();

  @override
  void initState() {
    _videoPlayerController =
        widget.recipe.media.first.mediaType - 1 == RecipeMediaType.video.index
            ? (VideoPlayerController.network(
                '$kBaseUrl/${widget.recipe.media.first.mediaPath}')
              ..initialize().then((_) {
                setState(() {});
              }))
            : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    HingUser? cachedUser = Hive.box<HingUser>(kUserBox).get(kUserKey);

    return ValueListenableBuilder<Box<HingUser>>(
        valueListenable: Hive.box<HingUser>(kUserBox).listenable(),
        builder: (context, cacheUser, child) {
          return Consumer<UserProvider>(
            builder: (context, UserProvider userProvider, child) =>
                SliverAppBar(
              expandedHeight: 350,
              toolbarHeight: 70,
              pinned: true,
              leadingWidth: 72,
              actions: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/shoppingList',
                            arguments: widget.recipe);
                      },
                      child: Stack(
                        children: [
                          SizedBox(
                            height: _height * 0.1,
                            width: _height * 0.09,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 16.0,
                                right: 16.0,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(48),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 4.0,
                                    sigmaY: 4.0,
                                  ),
                                  child: ColoredBox(
                                    color:
                                        const Color(0xFFC4C4C4).withOpacity(.5),
                                    child: SizedBox(
                                      height: _height * 0.1,
                                      width: _height * 0.09,
                                      child: FractionallySizedBox(
                                        heightFactor: 0.4,
                                        child: Image.asset(
                                            "assets/to-do-list.png",
                                            filterQuality: FilterQuality.high,
                                            fit: BoxFit.fitHeight,
                                            height: 24.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 15.0,
                            top: 15.0,
                            child: CircleAvatar(
                              radius: 8.0,
                              backgroundColor: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.recipe.user.id.oid != cachedUser!.id.oid)
                      InkWell(
                        onTap: () {
                          threeDotMenu(context);
                        },
                        child: SizedBox(
                          height: _height * 0.1,
                          width: _height * 0.09,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              right: 16.0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(48),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 4.0,
                                  sigmaY: 4.0,
                                ),
                                child: SizedBox(
                                  height: _height * 0.1,
                                  width: _height * 0.09,
                                  child: ColoredBox(
                                      color: const Color(0xFFC4C4C4)
                                          .withOpacity(.5),
                                      child: FractionallySizedBox(
                                        heightFactor: 0.55,
                                        child: SvgPicture.asset(
                                          "assets/report.svg",
                                          fit: BoxFit.fitHeight,
                                          color: Colors.white70,
                                          height: 24.0,
                                          width: 24.0,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
              leading: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(48),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4.0,
                      sigmaY: 4.0,
                    ),
                    child: ColoredBox(
                      color: const Color(0xFFC4C4C4).withOpacity(.5),
                      child: BackButton(),
                    ),
                  ),
                ),
              ),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                      child: Hero(
                          tag: '${widget.index}',
                          child: widget.recipe.media.first.mediaType - 1 ==
                                  RecipeMediaType.image.index
                              ? CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      '$kBaseUrl/${widget.recipe.media.first.mediaPath}',
                                  height: 208,
                                  width: double.infinity,
                                  errorWidget: (_, __, ___) =>
                                      const ErrorIllustration(),
                                  placeholder: (_, __) => const ToqueAnimation(
                                    size: 8.0,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (_videoPlayerController!.value.isPlaying)
                                      _videoPlayerController!.pause();
                                    else
                                      _videoPlayerController!.play();
                                  },
                                  child: _videoPlayerController
                                              ?.value.isInitialized ??
                                          false
                                      ? VisibilityDetector(
                                          key: Key(widget.index.toString()),
                                          onVisibilityChanged:
                                              (visibilityInfo) {
                                            if (visibilityInfo
                                                    .visibleFraction ==
                                                1.0) {
                                              _videoPlayerController!.play();
                                            } else {
                                              _videoPlayerController!.pause();
                                            }
                                          },
                                          child: AspectRatio(
                                              aspectRatio:
                                                  _videoPlayerController!
                                                      .value.aspectRatio,
                                              child: VideoPlayer(
                                                  _videoPlayerController!
                                                    ..play())))
                                      : Container(
                                          height: 208,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(.1))))),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: -1,
                      child: Container(
                        alignment: Alignment.center,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24))),
                        child: Container(
                          height: 4,
                          width: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.25),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }

  threeDotMenu(context) {
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
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Why are you reporting this post?",
                      style: Theme.of(context).textTheme.bodyText2,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 24,
                    ),
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
                                  // widget.refreshCallback(widget.recipe,
                                  //     shouldRefresh: true);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Reported Recipe")));
                                } else {
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
