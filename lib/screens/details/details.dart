import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/details/components/details_author_header.dart';
import 'package:hing/screens/details/components/details_tabs.dart';
import 'package:hing/screens/details/components/ingredients_list_item.dart';
import 'package:hing/screens/home/components/feed_item_footer.dart';
import 'components/details_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //final int index = ModalRoute.of(context)?.settings.arguments as int;
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Recipe recipe = data['recipe'];
    final int index = data['index'];
    final Function(Recipe recipe) refreshCallback = data['refresh_callback'];

    return Scaffold(
        body: DefaultTabController(
            length: 2,
            child: Stack(
              children: [
                NestedScrollView(
                    headerSliverBuilder: (context, reverse) => [
                          DetailsAppBar(
                            index: index,
                            recipe: recipe,
                          ),
                          SliverPadding(
                              padding: EdgeInsets.all(16),
                              sliver: SliverList(
                                  delegate: SliverChildListDelegate([
                                DetailsAuthorHeader(recipe: recipe),
                                Text(
                                  recipe.title,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: DetailsTab())
                              ])))
                        ],
                    body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TabBarView(children: [
                          SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Text(
                                recipe.description,
                                style: Theme.of(context).textTheme.bodyText2,
                              )),
                          ListView.builder(
                              itemCount: recipe.ingredients.length,
                              itemBuilder: (_, index) => IngredientsListItem(
                                  ingredient: recipe.ingredients[index]))
                        ]))),
                SafeArea(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FeedItemFooter(
                                    recipe: data['recipe'],
                                    refreshCallback: refreshCallback,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: ElevatedButton(
                                        onPressed: () => {},
                                        child:
                                            Text(S.of(context).addToFavorite),
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 24),
                                            minimumSize:
                                                Size(double.infinity, 48))),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  )
                                ]))))
              ],
            )));
  }
}
