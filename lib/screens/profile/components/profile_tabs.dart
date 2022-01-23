import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/screens/profile/components/tab_item.dart';
import 'package:hing/theme/colors.dart';

class ProfileTabs extends StatefulWidget {
  final HingUser user;
  const ProfileTabs({Key? key, required this.user}) : super(key: key);

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
            color: kOnSurfaceColor, borderRadius: BorderRadius.circular(16)),
        indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: const EdgeInsets.all(0),
        tabs: [
          ProfileTabItem(
              text: S.of(context).posts, count: widget.user.postsCount ?? 0),
          ProfileTabItem(
              text: S.of(context).following,
              count: widget.user.followingCount ?? 0),
          ProfileTabItem(
              text: S.of(context).followers,
              count: widget.user.followersCount ?? 0),
        ],
      ),
    );
  }
}
