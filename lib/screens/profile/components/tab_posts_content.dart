import 'package:flutter/material.dart';
import 'package:hing/screens/home/components/feed_item.dart';

class ProfileTabPostsContent extends StatefulWidget {
  const ProfileTabPostsContent({Key? key}) : super(key: key);

  @override
  _ProfileTabPostsContentState createState() => _ProfileTabPostsContentState();
}

class _ProfileTabPostsContentState extends State<ProfileTabPostsContent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();

    // ListView.builder(
    //     shrinkWrap: true,
    //     padding: EdgeInsets.only(bottom: 72),
    //     // physics: NeverScrollableScrollPhysics(),
    //     itemCount: 10,
    //     itemBuilder: (context, index) => FeedItem(
    //           index: index,
    //         ));
  }
}
