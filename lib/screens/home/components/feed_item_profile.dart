import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/theme/colors.dart';

class FeedItemProfile extends StatefulWidget {
  final Recipe recipe;
  const FeedItemProfile({Key? key, required this.recipe}) : super(key: key);

  @override
  _FeedItemProfileState createState() => _FeedItemProfileState();
}

class _FeedItemProfileState extends State<FeedItemProfile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: widget.recipe.user.image != null
              ? CachedNetworkImage(
                  height: 36,
                  width: 36,
                  imageUrl: '$kBaseUrl/${widget.recipe.user.image}',
                  errorWidget: (_, __, ___) => CircleAvatar(
                      radius: 36,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Icon(Icons.person_rounded,
                          color: Theme.of(context).colorScheme.onSurface)),
                )
              : CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.15),
                  child: Icon(Icons.person_rounded,
                      color: Theme.of(context).colorScheme.onSurface)),
        ),
        SizedBox(width: 8),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.recipe.user.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              widget.recipe.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: kBodyTextColor),
            )
          ],
        ))
      ],
    );
  }
}
