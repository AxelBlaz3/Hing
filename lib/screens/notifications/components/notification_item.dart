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
    final ThemeData themeData = Theme.of(context);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: widget.notification.otherUser.image != null
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 36,
                      width: 36,
                      imageUrl:
                          '$kBaseUrl/${widget.notification.otherUser.image}',
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
            Expanded(
                child: RichText(
              text: TextSpan(
                  text: widget.notification.notificationType ==
                          NotificationType.newFollower.index
                      ? S
                          .of(context)
                          .xFollowedY(widget.notification.otherUser.displayName)
                      : widget.notification.notificationType ==
                              NotificationType.likePost.index
                          ? S.of(context).xLikedYPost(
                              widget.notification.otherUser.displayName)
                          : widget.notification.notificationType ==
                                  NotificationType.likeReply.index
                              ? S.of(context).xLikeYReply(
                                  widget.notification.otherUser.displayName)
                              : widget.notification.notificationType ==
                                      NotificationType.likeComment.index
                                  ? S.of(context).xLikedYComment(
                                      widget.notification.otherUser.displayName)
                                  : widget.notification.notificationType ==
                                          NotificationType.newComment.index
                                      ? S.of(context).xCommentedOnYourRecipe(
                                          widget.notification.otherUser
                                              .displayName)
                                      : S.of(context).xLikedYComment(widget
                                          .notification.otherUser.displayName),
                  style: themeData.textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            ' ${timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.notification.createdAt.date), locale: 'en_short')}',
                        style: themeData.textTheme.caption?.copyWith(
                            color: themeData.colorScheme.onSurface
                                .withOpacity(.5)))
                  ]),
            )),
            SizedBox(
              width: 16,
            ),
          ],
        ));
  }
}
