import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatefulWidget {
  final HingUser user;
  const ProfileDetails({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  late HingUser user;

  @override
  void initState() {
    super.initState();

    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.user.displayName,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: 4,
        ),
        Consumer<UserProvider>(
            builder: (_, userProvider, __) => user.isFollowing!
                ? OutlinedButton(
                    onPressed: () {
                      final UserProvider userProvider =
                          context.read<UserProvider>();

                      userProvider
                          .unFollowUser(followeeId: widget.user.id.oid)
                          .then((success) {
                        if (success) {
                          final UserProvider userProvider =
                              context.read<UserProvider>();
                          user = user..isFollowing = !user.isFollowing!;

                          userProvider.notifyUserChanges();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(S.of(context).somethingWentWrong)));
                        }
                      });
                    },
                    child: Text(S.of(context).unfollow),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                  )
                : ElevatedButton(
                    onPressed: () {
                      final UserProvider userProvider =
                          context.read<UserProvider>();

                      userProvider
                          .followUser(followeeId: widget.user.id.oid)
                          .then((success) {
                        if (success) {
                          final UserProvider userProvider =
                              context.read<UserProvider>();
                          user = user..isFollowing = !user.isFollowing!;

                          userProvider.notifyUserChanges();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(S.of(context).somethingWentWrong)));
                        }
                      });
                    },
                    child: Text(S.of(context).follow),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                  ))
      ],
    );
  }
}
