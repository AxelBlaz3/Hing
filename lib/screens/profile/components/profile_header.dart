import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/screens/profile/components/profile_details.dart';
import 'package:hing/screens/profile/components/profile_photo.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

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
            Expanded(child: ProfileDetails()),
            IconButton(
              onPressed: () => {
                Navigator.of(context).pushNamed(kEditProfileRoute)
              },
              icon: SvgPicture.asset('assets/edit.svg'),
            )
          ],
        ));
  }
}
