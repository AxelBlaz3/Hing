import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/components/empty_illustration.dart';
import 'package:hing/screens/home/components/feed_item.dart';
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
              SliverAppBar(
                floating: true,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
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
                              onPressed: () {
                                // Refresh pagingController.
                                _pagingController.refresh();
                              },
                              icon: SvgPicture.asset(
                                  'assets/search_outline.svg'))),
                    )),
              ),
              SliverPadding(
                  padding: const EdgeInsets.only(bottom: 120),
                  sliver: PagedSliverList.separated(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Recipe>(
                        itemBuilder: (context, recipe, index) => FeedItem(
                            index: index,
                            recipe: recipe,
                            refreshCallback: (updatedRecipe, {bool shouldRefresh = false}) {}),
                        noItemsFoundIndicatorBuilder: (_) => EmptyIllustration(
                              assetPath: 'assets/no_recipes_illustration.png',
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
                  ))
            ],
          ),
        ));
  }

  void pagingListener(int pageKey) {
    final searchKeyword = _searchController.text;

    if (searchKeyword.isEmpty) {
      _pagingController.appendLastPage(<Recipe>[]);
      return;
    }

    final recipeProvider = context.read<RecipeProvider>();

    recipeProvider
        .searchRecipes(query: searchKeyword, page: pageKey)
        .then((recipes) {
      if (recipes.length < _pageSize) {
        _pagingController.appendLastPage(recipes);
      } else {
        _pagingController.appendPage(recipes, pageKey + 1);
      }
    });
  }
}
