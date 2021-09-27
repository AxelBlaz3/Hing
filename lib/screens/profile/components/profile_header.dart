import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
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
            ProfilePhoto(),
            SizedBox(width: 16),
            Expanded(child: ProfileDetails(user: widget.user)),
            IconButton(
              onPressed: () =>
                  {Navigator.of(context).pushNamed(kEditProfileRoute)},
              icon: SvgPicture.asset('assets/edit.svg'),
            )
          ],
        ));
  }
}
