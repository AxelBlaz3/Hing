import 'package:flutter/material.dart';

class ProfileTabDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  const ProfileTabDelegate({required this.tabBar});

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: tabBar,
      );

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate != this;
}
