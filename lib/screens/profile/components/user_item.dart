import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:hing/screens/components/user_placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class UserItem extends StatefulWidget {
  final HingUser user;
  final bool isFollowing;
  final Function(HingUser) refreshCallback;
  const UserItem(
      {Key? key,
      required this.user,
      required this.isFollowing,
      required this.refreshCallback})
      : super(key: key);

  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    final HingUser user = Hive.box<HingUser>(kUserBox).get(kUserKey)!;

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: widget.user.image != null
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 48,
                      width: 48,
                      imageUrl: '$kBaseUrl/${widget.user.image}',
                      placeholder: (_, __) => const UserPlaceholder(
                        size: 24,
                      ),
                      errorWidget: (_, __, ___) => const UserPlaceholder(
                        size: 24,
                      ),
                    )
                  : const UserPlaceholder(
                      size: 24,
                    ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                user.id.oid == widget.user.id.oid
                    ? '${widget.user.displayName} (${S.of(context).you})'
                    : widget.user.displayName,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            widget.user.isFollowing ?? false
                ? OutlinedButton(
                    onPressed: user.id.oid == widget.user.id.oid
                        ? null
                        : () async {
                            context
                                .read<UserProvider>()
                                .unFollowUser(followeeId: widget.user.id.oid)
                                .then((success) {
                              if (success) {
                                widget.refreshCallback(widget.user
                                  ..isFollowing = !widget.user.isFollowing!);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Retry')));
                              }
                            });
                          },
                    child: Text(S.of(context).unfollow),
                  )
                : ElevatedButton(
                    onPressed: user.id.oid == widget.user.id.oid
                        ? null
                        : () async {
                            context
                                .read<UserProvider>()
                                .followUser(followeeId: widget.user.id.oid)
                                .then((success) {
                              if (success) {
                                widget.refreshCallback(widget.user
                                  ..isFollowing = !widget.user.isFollowing!);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Retry')));
                              }
                            });
                          },
                    child: Text(S.of(context).follow),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 40),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24)),
                  )
          ],
        ));
  }
}
