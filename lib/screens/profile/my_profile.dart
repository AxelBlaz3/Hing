import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/components/empty_illustration.dart';
import 'package:hing/screens/home/components/feed_item.dart';
import 'package:hing/screens/profile/components/my_profile_header.dart';
import 'package:hing/screens/profile/components/profile_tab_delegate.dart';
import 'package:hing/theme/colors.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import 'components/user_item.dart';

class MyProfileScreen extends StatefulWidget {
  final HingUser user;

  const MyProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final int _perPage = 10;
  List<PagingController<int, dynamic>> _pagingControllers =
      <PagingController<int, dynamic>>[];
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  var _obscureText = true;
  var _obscureText1 = true;
  var _obscureText3 = true;

  @override
  void initState() {
    super.initState();

    final UserProvider userProvider = Provider.of(context, listen: false);

    for (var index = 0; index < kTotalProfileCategories; index++) {
      if (index == 0 || index == 1)
        _pagingControllers.add(PagingController<int, Recipe>(firstPageKey: 1));
      else
        _pagingControllers
            .add(PagingController<int, HingUser>(firstPageKey: 1));
    }

    for (var index = 0; index < kTotalProfileCategories; index++) {
      _pagingControllers[index].addPageRequestListener((pageKey) {
        switch (index) {
          case 0:
            userProvider.getPosts(page: pageKey).then((recipes) {
              if (recipes.length < _perPage) {
                _pagingControllers[index].appendLastPage(recipes);
              } else {
                _pagingControllers[index].appendPage(recipes, pageKey + 1);
              }
            });
            break;
          case 1:
            userProvider.getFavorites(page: pageKey).then((recipes) {
              if (recipes.length < _perPage) {
                _pagingControllers[index].appendLastPage(recipes);
              } else {
                _pagingControllers[index].appendPage(recipes, pageKey + 1);
              }
            });
            break;
          case 2:
            userProvider
                .getFollowers(page: pageKey, userId: widget.user.id.oid)
                .then((users) {
              if (users.length < _perPage) {
                _pagingControllers[index].appendLastPage(users);
              } else {
                _pagingControllers[index].appendPage(users, pageKey + 1);
              }
            });
            break;
          default:
            userProvider
                .getFollowing(page: pageKey, userId: widget.user.id.oid)
                .then((users) {
              if (users.length < _perPage) {
                _pagingControllers[index].appendLastPage(users);
              } else {
                _pagingControllers[index].appendPage(users, pageKey + 1);
              }
            });
            break;
        }
      });
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void togglePasswordVisibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void togglePasswordVisibility2() {
    setState(() {
      _obscureText3 = !_obscureText3;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _oldPasswordController.dispose();
    _confirmController.dispose();
    _passwordController.dispose();

    for (var index = 0; index < kTotalProfileCategories; index++) {
      _pagingControllers[index].dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabTitles = getMyProfileTabTitles(context);

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: kTotalProfileCategories,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (_, innerScroll) => [
              SliverAppBar(
                  title: Text(S.of(context).profile,
                      style: Theme.of(context).textTheme.headline6),
                  floating: true,
                  //snap: true,
                  leading: BackButton(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  expandedHeight: 96,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(96),
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Consumer<UserProvider>(
                            builder: (context, userProvider, child) =>
                                MyProfileHeader(
                                    user: userProvider.currentUser))),
                  ),
                  actions: [
                    PopupMenuButton(
                        icon: Icon(Icons.more_vert_rounded,
                            color: Theme.of(context).colorScheme.onSurface),
                        onSelected: (value) {
                          if (value == 0) {
                            changePassword(context);
                          }
                          if (value == 1) {
                            Hive.box<HingUser>(kUserBox).clear().then((value) =>
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    kLoginRoute, (route) => false));
                          }
                        },
                        itemBuilder: (_) => <PopupMenuEntry>[
                              PopupMenuItem(
                                  value: 0,
                                  child: Text(S.of(context).changePassword)),
                              PopupMenuItem(
                                  value: 1, child: Text(S.of(context).logout))
                            ])
                  ]),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: ProfileTabDelegate(
                      tabBar: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          isScrollable: true,
                          indicatorPadding: EdgeInsets.only(top: 4, bottom: 4),
                          tabs: List<Tab>.generate(
                              tabTitles.length,
                              (index) => Tab(
                                    child: FittedBox(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(.1),
                                            borderRadius:
                                                BorderRadius.circular(24)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        child: Text(
                                          tabTitles[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              ?.copyWith(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  )).toList())))
            ],
            body: TabBarView(
              children: List.generate(
                kTotalProfileCategories,
                (index) => RefreshIndicator(
                  onRefresh: () =>
                      Future.sync(() => _pagingControllers[index].refresh()),
                  child: index == 0 || index == 1
                      ? PagedListView<int, Recipe>.separated(
                          padding: const EdgeInsets.only(bottom: 72, top: 24),
                          separatorBuilder: (_, index) => Divider(
                                indent: 16.0,
                                endIndent: 16.0,
                                height: 4,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.75),
                              ),
                          pagingController: _pagingControllers[index]
                              as PagingController<int, Recipe>,
                          key: PageStorageKey(index),
                          builderDelegate: PagedChildBuilderDelegate(
                              noItemsFoundIndicatorBuilder: (_) =>
                                  EmptyIllustration(
                                    assetPath:
                                        'assets/no_recipes_illustration.png',
                                    title: S.of(context).noPostsTitle,
                                    summary: S.of(context).noPostsSummary,
                                  ),
                              itemBuilder: (_, recipe, childIndex) => FeedItem(
                                  index: childIndex,
                                  recipe: recipe,
                                  refreshCallback: (updatedRecipe,
                                      {bool shouldRefresh = false}) {
                                    if (index == 1) {
                                      // Check if recipe is not a favorite. If so, remove it from favorites list.
                                      if (!updatedRecipe.isFavorite) {
                                        _pagingControllers[index].itemList =
                                            List<Recipe>.of(
                                                (_pagingControllers[index]
                                                    .itemList as List<Recipe>)
                                                  ..removeAt(childIndex));
                                      } else {
                                        // Likes are updated. Don't remove the recipe from favorites, update it's likes instead.
                                        _pagingControllers[index].itemList =
                                            List<Recipe>.of(
                                                (_pagingControllers[index]
                                                        .itemList!
                                                      ..[childIndex] =
                                                          updatedRecipe)
                                                    as List<Recipe>);
                                      }

                                      // Refresh the other paging controller to sync with new list.
                                      _pagingControllers[index - 1].refresh();
                                    } else {
                                      _pagingControllers[index].itemList =
                                          List<Recipe>.of(
                                              (_pagingControllers[index]
                                                  .itemList as List<Recipe>)
                                                ..[childIndex] = updatedRecipe);

                                      _pagingControllers[index + 1].refresh();
                                    }
                                  })))
                      : PagedListView<int, HingUser>(
                          pagingController: _pagingControllers[index]
                              as PagingController<int, HingUser>,
                          builderDelegate: PagedChildBuilderDelegate(
                            noItemsFoundIndicatorBuilder: (_) =>
                                EmptyIllustration(
                              assetPath: 'assets/no_users_illustration.png',
                              title: S.of(context).noRecipesTitle,
                              summary: S.of(context).noUsersSummary,
                            ),
                            itemBuilder: (_, user, childIndex) => UserItem(
                              user: user,
                              isFollowing: user.isFollowing!,
                              refreshCallback: (updatedUser) {
                                final List<HingUser> updatedUsers;

                                // Remove item from list when index is 1 i.e., user unfollowed some other user.
                                if (index == tabTitles.length - 1) {
                                  updatedUsers = List.of(
                                      _pagingControllers[index].itemList
                                          as List<HingUser>
                                        ..removeAt(childIndex));

                                  _pagingControllers[index].itemList =
                                      updatedUsers;

                                  _pagingControllers[index - 1].refresh();
                                } else {
                                  updatedUsers = List.of(
                                      _pagingControllers[index].itemList
                                          as List<HingUser>
                                        ..[childIndex] = updatedUser);
                                  _pagingControllers[index].itemList =
                                      updatedUsers;

                                  _pagingControllers[index + 1].refresh();
                                }
                              },
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  changePassword(context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        context: context,
        builder: (BuildContext context) {
          bool isNewPasswordVisible = false;
          bool isCurrentPasswordVisible = false;
          bool isRepeatPassword = false;
          return StatefulBuilder(builder: (context, StateSetter state) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 24.0,
                  right: 24.0,
                  top: 24.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Current Password")),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: !isCurrentPasswordVisible,
                      controller: _oldPasswordController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: kOnSurfaceDarkColor,
                          suffixIcon: GestureDetector(
                              child: Icon(
                                isCurrentPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onTap: () {
                                state(() {
                                  isCurrentPasswordVisible =
                                      !isCurrentPasswordVisible;
                                });
                              })),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("New Password")),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      textInputAction: TextInputAction.next,
                      obscureText: !isNewPasswordVisible,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          fillColor: kOnSurfaceDarkColor,
                          suffixIcon: GestureDetector(
                              child: Icon(
                                isNewPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onTap: () {
                                state(() {
                                  isNewPasswordVisible = !isNewPasswordVisible;
                                });
                              })),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Confirm Password")),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      textInputAction: TextInputAction.done,
                      obscureText: !isRepeatPassword,
                      controller: _confirmController,
                      decoration: InputDecoration(
                        fillColor: kOnSurfaceDarkColor,
                        suffixIcon: GestureDetector(
                            child: Icon(
                              isRepeatPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onTap: () {
                              state(() {
                                isRepeatPassword = !isRepeatPassword;
                              });
                            }),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                          onPressed: () {
                            final UserProvider userProvider =
                                context.read<UserProvider>();
                            if (_passwordController.text ==
                                _confirmController.text) {
                              userProvider
                                  .changePassword(
                                      userId: userProvider.currentUser.id.oid,
                                      password: _confirmController.text,
                                      oldPassword: _oldPasswordController.text)
                                  .then(
                                (success) {
                                  if (success) {
                                    _oldPasswordController.clear();
                                    _passwordController.clear();
                                    _confirmController.clear();
                                    context
                                        .read<UserProvider>()
                                        .notifyUserChanges();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Password changes successfully")));
                                    Navigator.pop(context);
                                  } else {
                                    _oldPasswordController.clear();
                                    _passwordController.clear();
                                    _confirmController.clear();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Could not update password")));
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            } else {
                              _passwordController.clear();
                              _confirmController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Passwords doesn't match")));
                              Navigator.pop(context);
                            }
                          },
                          child: Text(S.of(context).changePassword)),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            );
          });
        });
  }
}
