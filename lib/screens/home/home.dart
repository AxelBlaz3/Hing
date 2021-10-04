import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/feed_provider.dart';
import 'package:hing/screens/components/empty_illustration.dart';
import 'package:hing/screens/components/toque_loading.dart';
import 'package:hing/screens/components/user_placeholder.dart';
import 'package:hing/screens/home/components/feed_item.dart';
import 'package:hing/screens/home/components/home_tab_delegate.dart';
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
            child: SafeArea(
                child: NestedScrollView(
              floatHeaderSlivers: true,
              physics: BouncingScrollPhysics(),
              headerSliverBuilder: (context, reverse) => [
                HomeAppBar(),
                SliverPersistentHeader(
                    pinned: true,
                    delegate: HomeTabDelegate(
                        tabBar: TabBar(
                      isScrollable: true,
                      indicatorPadding: const EdgeInsets.symmetric(vertical: 4),
                      tabs: getHomeCategories(context)
                          .map((e) => Tab(
                                  //text: e,
                                  child: FittedBox(
                                fit: BoxFit.cover,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(.1),
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Text(e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(fontSize: 14.0)),
                                ),
                              )))
                          .toList(),
                    )))
              ],
              body: TabBarView(
                  children: getHomeCategories(context)
                      .asMap()
                      .map((key, value) => MapEntry(
                          key,
                          RefreshIndicator(
                            onRefresh: () => Future.sync(
                                () => _pagingControllers[key].refresh()),
                            child: PagedListView.separated(
                              separatorBuilder: (_, index) => Divider(
                                indent: 16.0,
                                endIndent: 16.0,
                                height: 4,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.75),
                              ),
                              padding: EdgeInsets.only(bottom: 120),
                              key: PageStorageKey(key),
                              pagingController: _pagingControllers[key],
                              builderDelegate: PagedChildBuilderDelegate<
                                      Recipe>(
                                  newPageProgressIndicatorBuilder: (context) =>
                                      const ToqueLoading(
                                        size: 24,
                                      ),
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
                                          }),
                                  noItemsFoundIndicatorBuilder: (_) =>
                                      const EmptyIllustration()),
                            ),
                          )))
                      .values
                      .toList()),
            ))));
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
        automaticallyImplyLeading: false,
        title: SvgPicture.asset('assets/logo.svg'),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(
                  S.of(context).categories,
                  style: Theme.of(context).textTheme.headline5,
                ))),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(kNotificationRoute);
              },
              icon:
                  SizedBox(child: SvgPicture.asset('assets/notification.svg'))),
          IconButton(
              onPressed: () async {
                final HingUser? user =
                    Hive.box<HingUser>(kUserBox).get(kUserKey);
                Navigator.of(context)
                    .pushNamed(kMyProfileRoute, arguments: user);
              },
              icon: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    height: 32,
                    width: 32,
                    fit: BoxFit.cover,
                    imageUrl: '$kBaseUrl/${user?.image}',
                    errorWidget: (_, __, ___) => const UserPlaceholder(),
                    placeholder: (_, __) => const UserPlaceholder(),
                  ))),
        ]);
  }
}
