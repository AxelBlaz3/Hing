import 'package:flutter/material.dart';
import 'package:hing/screens/profile/components/user_item.dart';

class ProfileTabUserContent extends StatefulWidget {
  const ProfileTabUserContent({Key? key}) : super(key: key);

  @override
  _ProfileTabUserContentState createState() => _ProfileTabUserContentState();
}

class _ProfileTabUserContentState extends State<ProfileTabUserContent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 72),
        // physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => UserItem());
  }
}
