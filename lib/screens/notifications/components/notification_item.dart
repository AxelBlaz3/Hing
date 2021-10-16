import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/enums/notification_type.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_notification/hing_notification.dart';
import 'package:hing/screens/components/user_placeholder.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../constants.dart';

class NotificationItem extends StatefulWidget {
  final HingNotification notification;
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: widget.notification.notificationType ==
                NotificationType.likePost.index
            ? RecipeLikeNotification(notification: widget.notification)
            : widget.notification.notificationType ==
                    NotificationType.likeComment.index
                ? CommentLikeNotification(notification: widget.notification)
                : widget.notification.notificationType ==
                        NotificationType.likeReply.index
                    ? CommentLikeNotification(
                        notification: widget.notification,
                        isComment: false,
                      )
                    : widget.notification.notificationType ==
                            NotificationType.newComment.index
                        ? NewCommentNotification(
                            notification: widget.notification)
                        : widget.notification.notificationType ==
                                NotificationType.newReply.index
                            ? NewReplyNotification(
                                notification: widget.notification)
                            : NewFollowerNotification(
                                notification: widget.notification));
  }
}

class NotificationPhoto extends StatelessWidget {
  final HingNotification notification;
  const NotificationPhoto({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: notification.otherUser.image != null
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 36,
                  width: 36,
                  imageUrl: '$kBaseUrl/${notification.otherUser.image}',
                  errorWidget: (_, __, ___) => const UserPlaceholder(
                    size: 24,
                    backgroundSize: 20,
                  ),
                  placeholder: (_, __) => const UserPlaceholder(
                    size: 24,
                    backgroundSize: 20,
                  ),
                )
              : const UserPlaceholder(
                  size: 24,
                  backgroundSize: 20,
                ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}

class RecipeLikeNotification extends StatelessWidget {
  final HingNotification notification;
  const RecipeLikeNotification({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationPhoto(
            notification: notification,
          ),
          Expanded(
              child: RichText(
            text: TextSpan(
                // text: notification.otherUser.displayName,
                children: <TextSpan>[
                  TextSpan(
                    text: notification.otherUser.displayName,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  TextSpan(
                    text: S.of(context).likedYourRecipe,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  TextSpan(
                      text: notification.recipeNotification!.title,
                      style: Theme.of(context).textTheme.subtitle2),
                  TextSpan(
                      text:
                          '. ${timeago.format(DateTime.fromMillisecondsSinceEpoch(notification.createdAt.date), locale: 'en_short')}',
                      style: Theme.of(context).textTheme.caption),
                ]),
          ))
        ]);
  }
}

class NewFollowerNotification extends StatelessWidget {
  final HingNotification notification;
  const NewFollowerNotification({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NotificationPhoto(notification: notification),
        Expanded(
            child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: notification.otherUser.displayName,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            TextSpan(
              text: S.of(context).startedFollowingYou,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextSpan(
                text:
                    ' ${timeago.format(DateTime.fromMillisecondsSinceEpoch(notification.createdAt.date), locale: 'en_short')}',
                style: Theme.of(context).textTheme.caption),
          ]),
        ))
      ],
    );
  }
}

class CommentLikeNotification extends StatelessWidget {
  final HingNotification notification;
  final bool isComment;
  const CommentLikeNotification(
      {Key? key, required this.notification, this.isComment = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NotificationPhoto(notification: notification),
        Expanded(
            child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: notification.otherUser.displayName,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            TextSpan(
              text: isComment
                  ? S.of(context).likedYourComment
                  : S.of(context).likedYourReply,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextSpan(
              text: isComment
                  ? "\"${notification.commentNotification!.body}\""
                  : "\"${notification.replyNotification!.body}\"",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextSpan(
                text:
                    '. ${timeago.format(DateTime.fromMillisecondsSinceEpoch(notification.createdAt.date), locale: 'en_short')}',
                style: Theme.of(context).textTheme.caption),
          ]),
        ))
      ],
    );
  }
}

class NewCommentNotification extends StatelessWidget {
  final HingNotification notification;
  const NewCommentNotification({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NotificationPhoto(notification: notification),
        Expanded(
            child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: notification.otherUser.displayName,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            TextSpan(
              text: S.of(context).commentedOnYourRecipe,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextSpan(
              text: " - \"${notification.commentNotification!.body}\"",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextSpan(
                text:
                    '. ${timeago.format(DateTime.fromMillisecondsSinceEpoch(notification.createdAt.date), locale: 'en_short')}',
                style: Theme.of(context).textTheme.caption),
          ]),
        ))
      ],
    );
  }
}

class NewReplyNotification extends StatelessWidget {
  final HingNotification notification;
  const NewReplyNotification({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NotificationPhoto(notification: notification),
        Expanded(
            child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: notification.otherUser.displayName,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            TextSpan(
              text: S.of(context).repliedToYourComment,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextSpan(
              text: " - \"${notification.replyNotification!.body}\"",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            TextSpan(
                text:
                    '. ${timeago.format(DateTime.fromMillisecondsSinceEpoch(notification.createdAt.date), locale: 'en_short')}',
                style: Theme.of(context).textTheme.caption),
          ]),
        ))
      ],
    );
  }
}
