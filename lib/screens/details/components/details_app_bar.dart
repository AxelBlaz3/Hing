import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/models/recipe/recipe.dart';

import '../../../constants.dart';

class DetailsAppBar extends StatelessWidget {
  final int index;
  final Recipe recipe;
  const DetailsAppBar({Key? key, required this.index, required this.recipe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      leading: Container(
        padding: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(.25),
            borderRadius: BorderRadius.circular(24)),
        child: BackButton(),
      ),
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
              child: Hero(
                  tag: '$index',
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: '$kBaseUrl/${recipe.media.first.mediaPath}',
                    height: 208,
                    width: double.infinity,
                    errorWidget: (_, __, ___) => Placeholder(
                      fallbackHeight: 208,
                    ),
                  ))),
          Positioned(
              left: 0,
              right: 0,
              bottom: -1,
              child: Container(
                alignment: Alignment.center,
                height: 32,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24))),
                child: Container(
                  height: 4,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(.25),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
