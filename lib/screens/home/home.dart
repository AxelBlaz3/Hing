import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/feed_provider.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/home/components/feed_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  final int _pageSize = 10;
  List<String> homeCategories = <String>[];
  List<PagingController<int, Recipe>> _pagingControllers =
      <PagingController<int, Recipe>>[];

  @override
  void initState() {
    super.initState();

    _pagingControllers.addAll(List.generate(
        kTotalCategories + 1, (index) => PagingController(firstPageKey: 1)));

    final FeedProvider _feedProvider =
        Provider.of<FeedProvider>(context, listen: false);

    _pagingControllers.asMap().entries.forEach((controller) {
      controller.value.addPageRequestListener((pageKey) {
        _feedProvider
            .getRecipesForCategory(page: pageKey, category: controller.key)
            .then((recipes) {
          if (recipes.length < _pageSize)
            controller.value.appendLastPage(recipes);
          else
            controller.value.appendPage(recipes, pageKey + 1);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final RecipeProvider _recipeProvider = Provider.of(context, listen: false);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(kUploadRecipe);
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          heroTag: 'fab',
          child: SvgPicture.asset('assets/edit.svg'),
        ),
        body: DefaultTabController(
            length: kTotalCategories + 1,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              physics: BouncingScrollPhysics(),
              headerSliverBuilder: (context, reverse) => [
                HomeAppBar(),
              ],
              body: TabBarView(
                  children: getHomeCategories(context)
                      .asMap()
                      .map((key, value) => MapEntry(
                          key,
                          RefreshIndicator(
                            onRefresh: () => Future.sync(
                                () => _pagingControllers[key].refresh()),
                            child: PagedListView(
                              padding: EdgeInsets.only(bottom: 120),
                              key: PageStorageKey(key),
                              pagingController: _pagingControllers[key],
                              builderDelegate: PagedChildBuilderDelegate<
                                      Recipe>(
                                  itemBuilder: (context, recipe, index) =>
                                      FeedItem(
                                          index: index,
                                          recipe: recipe,
                                          refreshCallback: (Recipe newRecipe) {
                                            final List<Recipe> updatedRecipes =
                                                List.of(_pagingControllers[key]
                                                    .itemList!)
                                                  ..[index] = newRecipe;
                                            _pagingControllers[key].itemList =
                                                updatedRecipes;
                                          })),
                            ),
                          )))
                      .values
                      .toList()),
            )));
  }

  @override
  bool get wantKeepAlive => true;
}

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    final HingUser? user = Hive.box<HingUser>(kUserBox).get(kUserKey);

    return SliverAppBar(
      floating: true,
      pinned: true,
      automaticallyImplyLeading: false,
      title: SvgPicture.asset('assets/logo.svg'),
      actions: [
        IconButton(
            onPressed: () => {},
            icon: SizedBox(child: SvgPicture.asset('assets/notification.svg'))),
        IconButton(
            onPressed: () => {Navigator.of(context).pushNamed(kProfileRoute)},
            icon: user == null
                ? CircleAvatar(
                    radius: 16,
                    child: Icon(Icons.person_rounded,
                        color: Theme.of(context).colorScheme.onSurface),
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(.25),
                  )
                : CachedNetworkImage(
                    imageUrl: '$kBaseUrl/${user.image}',
                    errorWidget: (_, __, ___) => CircleAvatar(
                      radius: 16,
                      child: Icon(Icons.person_rounded,
                          color: Theme.of(context).colorScheme.onSurface),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.25),
                    ),
                  )),
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(117),
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      S.of(context).categories,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TabBar(
                      isScrollable: true,
                      tabs: getHomeCategories(context)
                          .map((e) => Tab(
                                  //text: e,
                                  child: FittedBox(
                                fit: BoxFit.cover,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(.1),
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Text(e,
                                      style:
                                          Theme.of(context).textTheme.button),
                                ),
                              )))
                          .toList(),
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ]))),
    );
  }
}
