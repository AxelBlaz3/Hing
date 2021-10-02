import 'package:flutter/material.dart';

class HomeTabDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  const HomeTabDelegate({required this.tabBar});

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        padding: EdgeInsets.only(left: 16, right: 16),
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
