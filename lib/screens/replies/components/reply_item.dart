import 'package:flutter/material.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/comments/components/comment_body.dart';
import 'package:hing/screens/comments/components/comment_footer.dart';
import 'package:hing/screens/comments/components/comment_header.dart';

class ReplyItem extends StatefulWidget {
  final bool isReply;
  final Recipe recipe;
  final Comment comment;
  final Function(Comment) refreshCallback;

  const ReplyItem(
      {Key? key,
      this.isReply = false,
      required this.recipe,
      required this.comment,
      required this.refreshCallback})
      : super(key: key);

  @override
  _ReplyItemState createState() => _ReplyItemState();
}

class _ReplyItemState extends State<ReplyItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommentHeader(isReply: widget.isReply, comment: widget.comment),
            CommentBody(comment: widget.comment),
            CommentFooter(
                isReply: widget.isReply,
                recipe: widget.recipe,
                comment: widget.comment,
                refreshCallback: widget.refreshCallback)
          ],
        ));
  }
}
