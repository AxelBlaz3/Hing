import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/models/recipe/recipe.dart';

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
            widget.iconPath.contains("share") ||
                    widget.iconPath.contains("message")
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      widget.iconPath,
                      height: 24.0,
                      color: Theme.of(context).textTheme.caption!.color,
                    ),
                  )
                : SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset(
                      widget.iconPath,
                      height: 24.0,
                      color: Theme.of(context).textTheme.caption!.color,
                    ),
                  ),
            const SizedBox(width: 8),
            AutoSizeText('${widget.countLabel}',
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                wrapWords: true,
                textScaleFactor: 0.9,
                style: Theme.of(context).textTheme.caption?.copyWith(
                    overflow: TextOverflow.clip,
                    color: Theme.of(context).textTheme.bodyText2!.color))
          ],
        ));
  }
}
