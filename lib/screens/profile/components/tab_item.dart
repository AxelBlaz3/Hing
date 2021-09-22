import 'package:flutter/material.dart';

class ProfileTabItem extends StatefulWidget {
  final String text;
  const ProfileTabItem({Key? key, required this.text}) : super(key: key);

  @override
  _ProfileTabItemState createState() => _ProfileTabItemState();
}

class _ProfileTabItemState extends State<ProfileTabItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '52',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground),
        ),
        SizedBox(
          height: 4,
        ),
        Text(widget.text,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground))
      ],
    );
  }
}
