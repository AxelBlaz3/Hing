import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/screens/profile/components/my_profile_details.dart';
import 'package:hing/screens/profile/components/profile_photo.dart';

class MyProfileHeader extends StatefulWidget {
  final HingUser user;
  const MyProfileHeader({Key? key, required this.user}) : super(key: key);

  @override
  _MyProfileHeaderState createState() => _MyProfileHeaderState();
}

class _MyProfileHeaderState extends State<MyProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePhoto(
          size: 56,
        ),
        SizedBox(width: 16),
        Expanded(
            child: MyProfileDetails(
          user: widget.user,
        )),
        IconButton(
          onPressed: () => {Navigator.of(context).pushNamed(kEditProfileRoute)},
          icon: SvgPicture.asset('assets/edit.svg'),
        )
      ],
    );
  }
}
