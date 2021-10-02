import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/screens/components/user_placeholder.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReplyHeader extends StatefulWidget {
  final bool isReply;
  final Comment comment;
  const ReplyHeader({Key? key, this.isReply = false, required this.comment})
      : super(key: key);

  @override
  _ReplyHeaderState createState() => _ReplyHeaderState();
}

class _ReplyHeaderState extends State<ReplyHeader> {
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
                        fit: BoxFit.cover,
                        height: widget.isReply ? 24 : 40,
                        width: widget.isReply ? 24 : 40,
                        imageUrl: '$kBaseUrl/${widget.comment.user.image}',
                        errorWidget: (_, __, ___) =>
                            const UserPlaceholder(size: 20, backgroundSize: 16),
                      )
                    : const UserPlaceholder(
                        size: 20,
                        backgroundSize: 16,
                      )),
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
