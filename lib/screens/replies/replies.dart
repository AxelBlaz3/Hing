import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/models/reply/reply.dart';
import 'package:hing/providers/comment_provider.dart';
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
  final PagingController<int, Reply> _pageController =
      PagingController<int, Reply>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();

    final CommentProvider _commentProvider =
        Provider.of(context, listen: false);

    _pageController.addPageRequestListener((pageKey) {
      _commentProvider
          .getRepliesForComment(commentId: widget.comment.id.oid, page: pageKey)
          .then((replies) => replies.length < _pageSize
              ? _pageController.appendLastPage(replies)
              : _pageController.appendPage(replies, pageKey + 1));
    });
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommentItem(
            recipe: widget.recipe,
            comment: widget.comment,
          ),
          const DashedLine(),
          Flexible(
            child: PagedListView(
              pagingController: _pageController,
                padding: EdgeInsets.only(left: 24),
                shrinkWrap: true,
                builderDelegate: PagedChildBuilderDelegate<Reply>(itemBuilder: (_, reply, index) => CommentItem(
                      isReply: true,
                      recipe: widget.recipe,
                      comment: reply
                    ))),
          )
        ],
      ),
    );
  }
}
