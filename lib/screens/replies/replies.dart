import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/models/reply/reply.dart';
import 'package:hing/providers/comment_provider.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:hing/screens/comments/components/comment_item.dart';
import 'package:hing/screens/replies/components/dashed_line.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class RepliesScreen extends StatefulWidget {
  final Recipe recipe;
  final Comment comment;
  const RepliesScreen({Key? key, required this.recipe, required this.comment})
      : super(key: key);

  @override
  _RepliesScreenState createState() => _RepliesScreenState();
}

class _RepliesScreenState extends State<RepliesScreen> {
  final int _pageSize = 10;
  final PagingController<int, Reply> _pagingController =
      PagingController<int, Reply>(firstPageKey: 1);

  final _bodyController = TextEditingController();

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
          .getRepliesForComment(commentId: widget.comment.id.oid, page: pageKey)
          .then((replies) => replies.length < _pageSize
              ? _pagingController.appendLastPage(replies)
              : _pagingController.appendPage(replies, pageKey + 1));
    });
  }

  @override
  void dispose() {
    super.dispose();

    _pagingController.dispose();
    _bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            S.of(context).replies,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        body: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommentItem(
                recipe: widget.recipe,
                comment: widget.comment,
              ),
              const DashedLine(),
              Flexible(
                child: PagedListView(
                    pagingController: _pagingController,
                    padding: EdgeInsets.only(left: 24),
                    shrinkWrap: true,
                    builderDelegate: PagedChildBuilderDelegate<Reply>(
                        itemBuilder: (_, reply, index) => CommentItem(
                            isReply: true,
                            recipe: widget.recipe,
                            comment: reply))),
              )
            ],
          ),
          SafeArea(
              child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Consumer<CommentProvider>(
                      builder: (_, commentProvider, __) => TextField(
                            maxLines: null,
                            controller: _bodyController,
                            decoration: InputDecoration(
                                hintText: S.of(context).typeYourReplyHere,
                                hintStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                suffixIcon: IconButton(
                                    onPressed: commentProvider.isCommentEmpty
                                        ? null
                                        : () async {
                                            final CommentProvider
                                                commentProvider =
                                                context.read<CommentProvider>();

                                            final Reply?
                                                reply =
                                                await commentProvider
                                                    .postNewReply(
                                                        commentId:
                                                            widget
                                                                .comment.id.oid,
                                                        recipeId: widget
                                                            .recipe.id.oid,
                                                        body: _bodyController
                                                            .text);

                                            if (reply != null) {
                                              _bodyController.text = '';
                                              _pagingController.itemList =
                                                  List.of([
                                                reply,
                                                ..._pagingController.itemList!
                                              ]);
                                              final Recipe updatedRecipe =
                                                  widget.recipe
                                                    ..commentsCount = widget
                                                            .comment
                                                            .repliesCount +
                                                        1;
                                              context
                                                  .read<CommentProvider>()
                                                  .notifyCommentChanges();

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
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
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
        ]));
  }
}
