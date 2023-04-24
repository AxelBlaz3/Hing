import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/providers/recipe_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MediaPicker extends StatelessWidget {
  const MediaPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () async {
              final _recipeProvider = context.read<RecipeProvider>();
              final imagePicker = ImagePicker();
              final image = await imagePicker.pickImage(
                source: ImageSource.gallery,
              );
              _recipeProvider.pickedImage = image;
            },
            child: Row(
              children: [
                Icon(Icons.photo_rounded,
                    color: Theme.of(context).colorScheme.onSurface),
                SizedBox(
                  width: 8,
                ),
                Text(S.of(context).image)
              ],
            )),
        SizedBox(width: 16),
        TextButton(
            onPressed: () async {
              final _recipeProvider = context.read<RecipeProvider>();
              final imagePicker = ImagePicker();
              _recipeProvider.setPickedVideo(
                  await imagePicker.pickVideo(source: ImageSource.gallery));
            },
            child: Row(
              children: [
                Icon(Icons.video_library_rounded,
                    color: Theme.of(context).colorScheme.onSurface),
                SizedBox(
                  width: 8,
                ),
                Text(S.of(context).video)
              ],
            )),
      ],
    );
  }
}
