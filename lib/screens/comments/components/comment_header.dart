import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentHeader extends StatefulWidget {
  final bool isReply;
  final Comment comment;
  const CommentHeader({Key? key, this.isReply = false, required this.comment})
      : super(key: key);

  @override
  _CommentHeaderState createState() => _CommentHeaderState();
}

class _CommentHeaderState extends State<CommentHeader> {
  @override
  Widget build(BuildContext context) {
    final commentCreatedAt =
        DateTime.fromMillisecondsSinceEpoch(widget.comment.createdAt.date);

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: widget.comment.user.image != null
                    ? CachedNetworkImage(
                        height: widget.isReply ? 24 : 40,
                        width: widget.isReply ? 24 : 40,
                        imageUrl: '$kBaseUrl/${widget.comment.user.image}',
                        errorWidget: (_, __, ___) => CircleAvatar(
                            radius: widget.isReply ? 24 : 40,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.25),
                            child: Icon(Icons.person_rounded,
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
                      )
                    : CircleAvatar(
                        radius: widget.isReply ? 14 : 16,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(.25),
                        child: Icon(Icons.person_rounded,
                            color: Theme.of(context).colorScheme.onSurface))),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: Text(
              widget.comment.user.displayName,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(fontSize: widget.isReply ? 12 : 14),
            )),
            Text(
              timeago.format(commentCreatedAt),
              style: Theme.of(context).textTheme.overline,
            )
          ],
        ));
  }
}
