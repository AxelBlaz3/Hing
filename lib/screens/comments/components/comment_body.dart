import 'package:flutter/material.dart';
import 'package:hing/models/comment/comment.dart';

class CommentBody extends StatefulWidget {
  final Comment comment;
  const CommentBody({Key? key, required this.comment}) : super(key: key);

  @override
  _CommentBodyState createState() => _CommentBodyState();
}

class _CommentBodyState extends State<CommentBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text(widget.comment.body,
            style: Theme.of(context).textTheme.caption));
  }
}
