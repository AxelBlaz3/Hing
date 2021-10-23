import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class PreviewMedia extends StatefulWidget {
  const PreviewMedia({Key? key}) : super(key: key);

  @override
  _PreviewMediaState createState() => _PreviewMediaState();
}

class _PreviewMediaState extends State<PreviewMedia> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Provider.of<RecipeProvider>(context, listen: false)
              .videoPlayerController
              ?.dispose();
          return Future.value(true);
        },
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Consumer<RecipeProvider>(builder: (_, recipeProvider, __) {
              return recipeProvider.pickedImage == null &&
                      recipeProvider.pickedVideo == null
                  ? DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(16),
                      strokeWidth: 2,
                      color: Theme.of(context).textTheme.bodyText1!.color!,
                      dashPattern: [8, 4],
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 56),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            S.of(context).preview,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            S.of(context).uploadPhotoDesc,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ))
                  : recipeProvider.pickedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            File(recipeProvider.pickedImage!.path),
                            fit: BoxFit.cover,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: AspectRatio(
                              aspectRatio: recipeProvider.videoPlayerController!
                                          .value.size.height >
                                      recipeProvider.videoPlayerController!
                                          .value.size.width
                                  ? recipeProvider.videoPlayerController!.value
                                          .size.width /
                                      recipeProvider.videoPlayerController!
                                          .value.size.height
                                  : recipeProvider.videoPlayerController!.value
                                          .size.width /
                                      recipeProvider.videoPlayerController!
                                          .value.size.height,
                              child: VideoPlayer(recipeProvider.videoPlayerController!)));
            })));
  }
}
