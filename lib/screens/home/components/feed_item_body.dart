import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/screens/components/error_illustration.dart';
import 'package:hing/screens/components/toque_placeholder.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FeedItemBody extends StatefulWidget {
  final int index;
  final Recipe recipe;
  const FeedItemBody({Key? key, required this.index, required this.recipe})
      : super(key: key);

  @override
  _FeedItemBodyState createState() => _FeedItemBodyState();
}

class _FeedItemBodyState extends State<FeedItemBody> {
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
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Hero(
          tag: '${widget.index}',
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: widget.recipe.media.first.mediaType - 1 ==
                      RecipeMediaType.image.index
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          '$kBaseUrl/${widget.recipe.media.first.mediaPath}',
                      height: 208,
                      width: double.infinity,
                      errorWidget: (_, __, ___) => const ErrorIllustration(),
                      placeholder: (_, __) => const ToqueAnimation(
                        size: 8.0,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (_videoPlayerController!.value.isPlaying)
                          _videoPlayerController!.pause();
                        else
                          _videoPlayerController!.play();
                      },
                      child: _videoPlayerController?.value.isInitialized ??
                              false
                          ? VisibilityDetector(
                              key: Key(widget.index.toString()),
                              onVisibilityChanged: (visibilityInfo) {
                                if (visibilityInfo.visibleFraction == 1.0) {
                                  _videoPlayerController!.play();
                                } else {
                                  _videoPlayerController!.pause();
                                }
                              },
                              child: AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController!.value.aspectRatio,
                                  child: VideoPlayer(
                                      _videoPlayerController!..play())))
                          : Container(
                              height: 208,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(.1)))),
        ));
  }
}
