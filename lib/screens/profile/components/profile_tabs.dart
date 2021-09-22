import 'package:flutter/material.dart';
import 'package:hing/screens/profile/components/tab_item.dart';

class ProfileTabs extends StatefulWidget {
  const ProfileTabs({Key? key}) : super(key: key);

  @override
  _ProfileTabsState createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(top: 32, left: 48, right: 48),
      //padding: EdgeInsets.all(16),
      child: TabBar(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        indicator: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(16)),
        indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: const EdgeInsets.all(0),
        tabs: [
          ProfileTabItem(
            text: 'Posts',
          ),
          ProfileTabItem(
            text: 'Following',
          ),
          ProfileTabItem(
            text: 'Followers',
          ),
        ],
      ),
    );
  }
}
