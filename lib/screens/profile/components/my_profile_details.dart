import 'package:flutter/material.dart';
import 'package:hing/models/hing_user/hing_user.dart';

class MyProfileDetails extends StatefulWidget {
  final HingUser user;
  const MyProfileDetails({Key? key, required this.user}) : super(key: key);

  @override
  _MyProfileDetailsState createState() => _MyProfileDetailsState();
}

class _MyProfileDetailsState extends State<MyProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.user.displayName,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          widget.user.email!,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
