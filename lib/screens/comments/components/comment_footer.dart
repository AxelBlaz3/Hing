import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/home/components/feed_action_item.dart';

class CommentFooter extends StatefulWidget {
  final Recipe recipe;
  final Comment comment;
  const CommentFooter({Key? key, required this.recipe, required this.comment})
      : super(key: key);

  @override
  _CommentFooterState createState() => _CommentFooterState();
}

class _CommentFooterState extends State<CommentFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        FeedActionItem(
          iconPath: widget.comment.isLiked
              ? 'assets/star_filled.svg'
              : 'assets/star.svg',
          recipe: widget.recipe,
          countLabel: widget.comment.likesCount > 0
              ? S.of(context).xLikes(widget.comment.likesCount)
              : S.of(context).like,
          onPressed: () {},
        ),
        SizedBox(
          width: 16,
        ),
        FeedActionItem(
          iconPath: 'assets/chat.svg',
          recipe: widget.recipe,
          countLabel: widget.comment.repliesCount > 0
              ? S.of(context).xReplies(widget.comment.repliesCount)
              : S.of(context).reply,
          onPressed: () {
            Navigator.of(context).pushNamed(kRepliesRoute, arguments: {
              'recipe': widget.recipe,
              'comment': widget.comment
            });
          },
        ),
      ],
    );
  }
}
