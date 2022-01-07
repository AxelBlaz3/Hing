import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/object_id/object_id.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/components/empty_illustration.dart';
import 'package:hing/screens/components/user_placeholder.dart';
import 'package:hing/screens/home/components/feed_item.dart';
import 'package:hing/theme/colors.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/src/provider.dart';

import '../../constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PagingController<int, Recipe> _pagingController =
      PagingController(firstPageKey: 1);
  final int _pageSize = 10;
  List<HingUser> users = [];
  List<Recipe> recipes = [];

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
    _pagingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(pagingListener);
    _pagingController.notifyPageRequestListeners(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(kUploadRecipe);
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: SvgPicture.asset('assets/edit.svg'),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              SliverAppBar(
                floating: true,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      onSubmitted: (val) {
                        final pageKey = 1;
                        final recipeProvider = context.read<RecipeProvider>();

                        recipeProvider
                            .searchRecipes(
                                query: _searchController.text, page: pageKey)
                            .then((data) {
                          setState(() {
                            users = data["users"];
                            recipes = data["recipes"];
                          });
                          if (recipes.length < _pageSize) {
                            _pagingController.appendLastPage(data["recipes"]);
                          } else {
                            _pagingController.appendPage(
                                data["recipes"], pageKey + 1);
                          }
                        });
                        _pagingController.refresh();
                      },
                      textAlignVertical: TextAlignVertical.center,
                      controller: _searchController,
                      decoration: InputDecoration(
                          isCollapsed: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(48.0),
                              borderSide: BorderSide.none),
                          hintText: S.of(context).search,
                          prefixIcon: BackButton(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          suffixIcon: IconButton(
                              highlightColor: Colors.white,
                              splashColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              onPressed: () async {
                                final pageKey = 1;
                                final recipeProvider =
                                    context.read<RecipeProvider>();

                                recipeProvider
                                    .searchRecipes(
                                        query: _searchController.text,
                                        page: pageKey)
                                    .then((data) {
                                  setState(() {
                                    users = data["users"];
                                    recipes = data["recipes"];
                                  });
                                  if (recipes.length < _pageSize) {
                                    _pagingController
                                        .appendLastPage(data["recipes"]);
                                  } else {
                                    _pagingController.appendPage(
                                        data["recipes"], pageKey + 1);
                                  }
                                });
                                _pagingController.refresh();
                              },
                              icon: SvgPicture.asset(
                                  'assets/search_outline.svg',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface))),
                    )),
              ),
              users.isEmpty && recipes.isEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.3,
                          horizontal: 24.0,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 56.0,
                              width: 56.0,
                              child: Image.asset(
                                'assets/no_recipes_illustration.png',
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(S.of(context).noRecipesTitle,
                                style: Theme.of(context).textTheme.headline6),
                            const SizedBox(height: 8.0),
                            Text(
                              S.of(context).noRecipesFound,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverToBoxAdapter(),
              users.isEmpty && recipes.isEmpty
                  ? SliverToBoxAdapter()
                  : users.isEmpty && recipes.isNotEmpty
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              "Profiles",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        )
                      : SliverToBoxAdapter(),
              users.isEmpty && recipes.isEmpty
                  ? SliverToBoxAdapter()
                  : users.isEmpty && recipes.isNotEmpty
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 8.0),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              "No profiles found  !",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                  ),
                            ),
                          ),
                        )
                      : SliverToBoxAdapter(),
              SliverList(
                key: UniqueKey(),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        final cachedUser =
                            Hive.box<HingUser>(kUserBox).get(kUserKey);

                        if (cachedUser!.id.oid == users[index].id.oid) {
                          // My Profile.
                          Navigator.of(context).pushNamed(kMyProfileRoute,
                              arguments: cachedUser);
                        } else {
                          // User profile.

                          Navigator.of(context).pushNamed(kProfileRoute,
                              arguments: users[index]);
                        }
                      },
                      child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: users[index].image != null
                                ? CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 36,
                                    width: 36,
                                    imageUrl: '$kBaseUrl/${users[index].image}',
                                    errorWidget: (_, __, ___) =>
                                        const UserPlaceholder(size: 24),
                                    placeholder: (_, __) =>
                                        const UserPlaceholder(size: 24),
                                  )
                                : const UserPlaceholder(size: 24),
                          ),
                          title: Text(users[index].displayName)),
                    );
                  },
                  childCount: users.length,
                ),
              ),
              recipes.isEmpty && users.isEmpty
                  ? SliverToBoxAdapter()
                  : SliverToBoxAdapter(
                      child: Divider(
                        endIndent: 12.0,
                        indent: 12.0,
                        color: kBodyTextColor,
                      ),
                    ),
              users.isNotEmpty || recipes.isNotEmpty
                  ? SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          "Recipes",
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    )
                  : SliverToBoxAdapter(),
              recipes.isEmpty && users.isEmpty
                  ? SliverToBoxAdapter()
                  : recipes.isEmpty
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              "No recipes found !",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                  ),
                            ),
                          ),
                        )
                      : SliverToBoxAdapter(),
              recipes.isEmpty
                  ? SliverToBoxAdapter()
                  : SliverPadding(
                      padding: const EdgeInsets.only(bottom: 120),
                      sliver: PagedSliverList.separated(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Recipe>(
                            itemBuilder: (context, recipe, index) {
                              return FeedItem(
                                  fromProfilePage: false,
                                  index: index,
                                  recipe: recipe,
                                  refreshCallback: (updatedRecipe,
                                      {bool shouldRefresh = false}) {});
                            },
                            noItemsFoundIndicatorBuilder: (_) =>
                                EmptyIllustration(
                                  assetPath:
                                      'assets/no_recipes_illustration.png',
                                  title: S.of(context).noRecipesTitle,
                                  summary: S.of(context).noRecipesFound,
                                )),
                        separatorBuilder: (context, index) => Divider(
                          indent: 16.0,
                          endIndent: 16.0,
                          height: 4,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.75),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }

  void pagingListener(int pageKey) {
    try {
      final String searchKeyword = _searchController.text;

      if (searchKeyword.isEmpty) {
        _pagingController.appendLastPage(<Recipe>[]);
        return;
      }

      final recipeProvider = context.read<RecipeProvider>();

      recipeProvider
          .searchRecipes(query: searchKeyword, page: pageKey)
          .then((data) {
        setState(() {
          users = data["users"];
          recipes = data["recipes"];
        });
        if (recipes.length < _pageSize) {
          _pagingController.appendLastPage(data["recipes"]);
        } else {
          _pagingController.appendPage(data["recipes"], pageKey + 1);
        }
      });
    } catch (error) {
      print("error is $error");
    }
  }
}
