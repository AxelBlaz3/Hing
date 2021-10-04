import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/components/error_illustration.dart';
import 'package:hing/screens/components/toque_placeholder.dart';
import 'package:video_player/video_player.dart';

import '../../../constants.dart';

class DetailsAppBar extends StatefulWidget {
  final int index;
  final Recipe recipe;
  const DetailsAppBar({Key? key, required this.index, required this.recipe})
      : super(key: key);

  @override
  _DetailsAppBarState createState() => _DetailsAppBarState();
}

class _DetailsAppBarState extends State<DetailsAppBar> {

  VideoPlayerController? _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _videoPlayerController =
        widget.recipe.media.first.mediaType - 1 == RecipeMediaType.video.index
            ? (VideoPlayerController.network(
                '$kBaseUrl/${widget.recipe.media.first.mediaPath}')
              ..initialize().then((_) {
                setState(() {});
              }))
            : null;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      toolbarHeight: 144,
      pinned: true,
      leadingWidth: 72,
      leading: Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 72, top: 16),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(48),
              child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 4.0,
                    sigmaY: 4.0,
                  ),
                  child: ColoredBox(
                    color: const Color(0xFFC4C4C4).withOpacity(.5),
                    child: BackButton(),
                  )))),
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
              child: Hero(
                  tag: '${widget.index}',
                  child: widget.recipe.media.first.mediaType - 1 ==
                      RecipeMediaType.image.index
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          '$kBaseUrl/${widget.recipe.media.first.mediaPath}',
                      height: 208,
                      width: double.infinity,
                      errorWidget: (_, __, ___) => const ErrorIllustration(),
                      placeholder: (_, __) => const ToqueAnimation(size: 8.0,),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (_videoPlayerController!.value.isPlaying)
                          _videoPlayerController!.pause();
                        else
                          _videoPlayerController!.play();
                      },
                      child: _videoPlayerController?.value.isInitialized ?? false
                          ? AspectRatio(
                              aspectRatio:
                                  _videoPlayerController!.value.aspectRatio,
                              child:
                                  VideoPlayer(_videoPlayerController!..play()))
                          : Container(
                              height: 208,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(.1))))),
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
