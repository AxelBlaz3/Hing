import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/profile/components/profile_header.dart';
import 'package:hing/screens/profile/components/profile_tab_user_content.dart';
import 'package:hing/screens/profile/components/profile_tabs.dart';
import 'package:hing/screens/profile/components/tab_posts_content.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final HingUser user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PagingController<int, Recipe> _postsPagingController =
      PagingController<int, Recipe>(firstPageKey: 1);
  PagingController<int, HingUser> _followingPagingController =
      PagingController<int, HingUser>(firstPageKey: 1);
  PagingController<int, HingUser> _followersPagingController =
      PagingController<int, HingUser>(firstPageKey: 1);
  final int _perPage = 10;
  int pageKeyValue = 1;

  late HingUser user;
  List<Recipe> recipesData = [];
  List<HingUser> followers = [];
  List<HingUser> following = [];

  @override
  void initState() {
    super.initState();

    user = widget.user;

    final UserProvider userProvider = Provider.of(context, listen: false);

    _postsPagingController.addPageRequestListener((pageKey) {
      userProvider
          .getPosts(page: pageKey, userId: widget.user.id.oid)
          .then((recipes) {
        setState(() {
          recipesData = recipes;
          widget.user.postsCount = recipesData.length;
          pageKeyValue = pageKey;
        });
        if (recipes.length < _perPage) {
          _postsPagingController.appendLastPage(recipes);
        } else {
          _postsPagingController.appendPage(recipes, pageKey + 1);
        }
      });
    });
    // userProvider
    //     .getPosts(page: pageKeyValue, userId: widget.user.id.oid)
    //     .then((recipes) {
    //   setState(() {
    //     recipesData = recipes;
    //     widget.user.postsCount = recipesData.length;
    //   });
    //   if (recipes.length < _perPage) {
    //     _postsPagingController.appendLastPage(recipes);
    //   } else {
    //     _postsPagingController.appendPage(recipes, pageKeyValue + 1);
    //   }
    // });

    _followersPagingController.addPageRequestListener((pageKey) {
      userProvider
          .getFollowers(page: pageKey, userId: widget.user.id.oid)
          .then((users) {
        setState(() {
          followers = users;
          pageKeyValue = pageKey;

          widget.user.followersCount = followers.length;
        });
        if (users.length < _perPage) {
          _followersPagingController.appendLastPage(users);
        } else {
          _followersPagingController.appendPage(users, pageKey + 1);
        }
      });
    });
    userProvider
        .getFollowers(page: pageKeyValue, userId: widget.user.id.oid)
        .then((users) {
      setState(() {
        followers = users;
        widget.user.followersCount = followers.length;
      });
      if (users.length < _perPage) {
        _followersPagingController.appendLastPage(users);
      } else {
        _followersPagingController.appendPage(users, pageKeyValue + 1);
      }
    });

    _followingPagingController.addPageRequestListener((pageKey) {
      userProvider
          .getFollowing(page: pageKey, userId: widget.user.id.oid)
          .then((users) {
        setState(() {
          pageKeyValue = pageKey;

          following = users;
          widget.user.followingCount = following.length;
        });
        if (users.length < _perPage) {
          _followingPagingController.appendLastPage(users);
        } else {
          _followingPagingController.appendPage(users, pageKey + 1);
        }
      });
    });
    userProvider
        .getFollowing(page: pageKeyValue, userId: widget.user.id.oid)
        .then((users) {
      setState(() {
        following = users;
        widget.user.followingCount = following.length;
      });
      if (users.length < _perPage) {
        _followingPagingController.appendLastPage(users);
      } else {
        _followingPagingController.appendPage(users, pageKeyValue + 1);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _followersPagingController.dispose();
    _followingPagingController.dispose();
    _postsPagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
              headerSliverBuilder: (context, reverse) => [
                    SliverAppBar(
                        floating: true,
                        leading: BackButton(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        title: Text(
                          S.of(context).profile,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        actions: [
                          PopupMenuButton(
                              icon: Icon(Icons.more_vert_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                              onSelected: (value) {
                                if (value == 0) {
                                  final user = Hive.box<HingUser>(kUserBox)
                                      .get(kUserKey);
                                  final userProvider =
                                      Provider.of<UserProvider>(context,
                                          listen: false);
                                  userProvider
                                      .blockUser(
                                          userId: user!.id.oid,
                                          blockUserId: widget.user.id.oid)
                                      .then((success) {
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("User Blocked")));

                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              "/home", (route) => false);

                                      // widget.refreshCallback(widget.recipe,
                                      //     shouldRefresh: true);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Couldn't Block user")));
                                    }
                                  });
                                  Navigator.pop(context);
                                }
                              },
                              itemBuilder: (_) => <PopupMenuEntry>[
                                    PopupMenuItem(
                                      value: 0,
                                      child: Text("Block"),
                                    ),
                                  ])
                        ]),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Consumer<UserProvider>(
                              builder: (_, userProvider, __) =>
                                  ProfileHeader(user: user)),
                          Consumer<UserProvider>(
                            builder: (_, userProvider, __) =>
                                ProfileTabs(user: user),
                          ),
                        ],
                      ),
                    )
                  ],
              body: TabBarView(children: [
                ProfileTabPostsContent(
                    user: widget.user,
                    pagingController: _postsPagingController),
                ProfileTabUserContent(
                    shouldFetchFollowers: false,
                    user: widget.user,
                    pagingController: _followingPagingController,
                    refreshCallback: (updatedUser) {
                      _followersPagingController.refresh();

                      // Check if updatedUser is the current user's profile page. If so, update the user.
                      if (updatedUser.id.oid == user.id.oid) {
                        user = updatedUser;
                        Provider.of<UserProvider>(context, listen: false)
                            .notifyUserChanges();
                      }
                    }),
                ProfileTabUserContent(
                    shouldFetchFollowers: true,
                    user: widget.user,
                    pagingController: _followersPagingController,
                    refreshCallback: (updatedUser) {
                      _followingPagingController.refresh();

                      // Check if updatedUser is the current user's profile page. If so, update the user.
                      if (updatedUser.id.oid == user.id.oid) {
                        user = updatedUser;
                        Provider.of<UserProvider>(context, listen: false)
                            .notifyUserChanges();
                      }
                    }),
              ]))),
    );
  }
}
