import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/comment_provider.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/comments/components/comment_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final Recipe recipe;
  final Function(Recipe updatedRecipe) refreshCallback;
  const CommentsScreen(
      {Key? key, required this.recipe, required this.refreshCallback})
      : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _bodyController = TextEditingController();

  final PagingController<int, Comment> _pagingController =
      PagingController<int, Comment>(firstPageKey: 1);
  final int _pageSize = 10;

  @override
  void dispose() {
    _pagingController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final CommentProvider _commentProvider =
        Provider.of(context, listen: false);

    _bodyController.addListener(() {
      _commentProvider.setIsCommentEmpty(_bodyController.text.isEmpty);
    });

    _pagingController.addPageRequestListener((pageKey) {
      _commentProvider
          .getCommentsForRecipe(recipeId: widget.recipe.id.oid, page: pageKey)
          .then((comments) => comments.length < _pageSize
              ? _pagingController.appendLastPage(comments)
              : _pagingController.appendPage(comments, pageKey + 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        title: Text(
          S.of(context).comments,
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Stack(children: [
        RefreshIndicator(
            onRefresh: () => Future.sync(() => _pagingController.refresh()),
            child: PagedListView(
                padding: EdgeInsets.only(bottom: 120),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Comment>(
                    animateTransitions: true,
                    itemBuilder: (_, comment, index) =>
                        CommentItem(recipe: widget.recipe, comment: comment)))),
        SafeArea(
            child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Consumer<CommentProvider>(
                    builder: (_, commentProvider, __) => TextField(
                          maxLines: null,
                          controller: _bodyController,
                          decoration: InputDecoration(
                              hintText: S.of(context).typeYourCommentHere,
                              hintStyle: Theme.of(context).textTheme.bodyText2,
                              suffixIcon: IconButton(
                                  onPressed: commentProvider.isCommentEmpty
                                      ? null
                                      : () async {
                                          final CommentProvider
                                              commentProvider =
                                              context.read<CommentProvider>();

                                          final Comment? comment =
                                              await commentProvider
                                                  .postNewComment(
                                                      recipeId:
                                                          widget.recipe.id.oid,
                                                      body:
                                                          _bodyController.text);

                                          if (comment != null) {
                                            _bodyController.text = '';
                                            _pagingController.itemList =
                                                List.of([
                                              comment,
                                              ..._pagingController.itemList!
                                            ]);
                                            final Recipe updatedRecipe = widget
                                                .recipe
                                              ..commentsCount =
                                                  widget.recipe.commentsCount +
                                                      1;
                                            widget
                                                .refreshCallback(updatedRecipe);
                                                
                                            context
                                                .read<RecipeProvider>()
                                                .notifyRecipeChanges();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text('Retry')));
                                          }
                                        },
                                  icon: SvgPicture.asset(
                                    'assets/send.svg',
                                    color: commentProvider.isCommentEmpty
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(.25)
                                        : Theme.of(context).colorScheme.primary,
                                  )),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(.25)))),
                        ))))
      ]),
    );
  }
}
