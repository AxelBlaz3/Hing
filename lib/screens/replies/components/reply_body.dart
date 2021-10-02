import 'package:flutter/material.dart';
import 'package:hing/models/comment/comment.dart';

class ReplyBody extends StatefulWidget {
  final Comment comment;
  const ReplyBody({Key? key, required this.comment}) : super(key: key);

  @override
  _ReplyBodyState createState() => _ReplyBodyState();
}

class _ReplyBodyState extends State<ReplyBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text(widget.comment.body,
            style: Theme.of(context).textTheme.caption));
  }
}
