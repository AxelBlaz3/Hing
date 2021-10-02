import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/components/user_placeholder.dart';
import 'package:hing/theme/colors.dart';

class FeedItemProfile extends StatefulWidget {
  final Recipe recipe;
  final bool isDetailScreen;
  const FeedItemProfile(
      {Key? key, required this.recipe, this.isDetailScreen = false})
      : super(key: key);

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
                fit: BoxFit.cover,
                  height: 36,
                  width: 36,
                  imageUrl: '$kBaseUrl/${widget.recipe.user.image}',
                  errorWidget: (_, __, ___) => const UserPlaceholder(size: 24),
                  placeholder: (_, __) => const UserPlaceholder(size: 24),
                )
              : const UserPlaceholder(size: 24),
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
            if (!widget.isDetailScreen)
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
