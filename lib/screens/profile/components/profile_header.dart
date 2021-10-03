import 'package:flutter/material.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/screens/profile/components/profile_details.dart';
import 'package:hing/screens/profile/components/profile_photo.dart';

class ProfileHeader extends StatefulWidget {
  final HingUser user;
  const ProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary)),
                child: ProfilePhoto(
                  user: widget.user,
                  size: 56,
                )),
            SizedBox(width: 16),
            Expanded(child: ProfileDetails(user: widget.user))
          ],
        ));
  }
}
