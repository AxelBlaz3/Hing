import 'package:flutter/material.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/comments/components/comment_body.dart';
import 'package:hing/screens/comments/components/comment_footer.dart';
import 'package:hing/screens/comments/components/comment_header.dart';

class CommentItem extends StatefulWidget {
  final bool isReply;
  final Recipe recipe;
  final Comment comment;
  const CommentItem(
      {Key? key,
      this.isReply = false,
      required this.recipe,
      required this.comment})
      : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
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
              recipe: widget.recipe,
              comment: widget.comment,
            )
          ],
        ));
  }
}
