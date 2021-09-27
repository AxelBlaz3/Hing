import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/theme/colors.dart';

class FeedActionItem extends StatefulWidget {
  final Recipe recipe;
  final String iconPath;
  final String countLabel;
  final Function() onPressed;
  const FeedActionItem(
      {Key? key,
      required this.iconPath,
      required this.recipe,
      required this.countLabel,
      required this.onPressed})
      : super(key: key);

  @override
  _FeedActionItemState createState() => _FeedActionItemState();
}

class _FeedActionItemState extends State<FeedActionItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(widget.iconPath),
            ),
            SizedBox(
              width: 8,
            ),
            Text('${widget.countLabel}',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(color: kBodyTextColor))
          ],
        ));
  }
}
