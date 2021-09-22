import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/custom/line_tab_indicator.dart';

class DetailsTab extends StatefulWidget {
  const DetailsTab({Key? key}) : super(key: key);

  @override
  _DetailsTabState createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: LineTabIndicator(),
      indicatorSize: TabBarIndicatorSize.label,
      isScrollable: false,
      tabs: detailTabs
          .map((e) => Tab(
                text: e,
                //     child: FittedBox(
                //   fit: BoxFit.cover,
                //   child: Container(
                //     // margin: EdgeInsets.symmetric(vertical: 8),
                //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                //     decoration: BoxDecoration(
                //         color:
                //             Theme.of(context).colorScheme.primary.withOpacity(.1),
                //         borderRadius: BorderRadius.circular(24)),
                //     child: Text(e,
                //         style: Theme.of(context)
                //             .textTheme
                //             .overline
                //             ?.copyWith(fontWeight: FontWeight.bold)),
                //   ),
                // )
              ))
          .toList(),
    );
  }
}
