import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';

class ProfileDetails extends StatefulWidget {
  final HingUser user;
  const ProfileDetails({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
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
        widget.user.isFollowing!
            ? OutlinedButton(
                onPressed: () => {},
                child: Text(S.of(context).unfollow),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
              )
            : ElevatedButton(
                onPressed: () => {},
                child: Text(S.of(context).follow),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
              )
      ],
    );
  }
}
