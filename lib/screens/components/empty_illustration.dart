import 'package:flutter/material.dart';

class EmptyIllustration extends StatelessWidget {
  final String assetPath;
  final String title;
  final String summary;
  const EmptyIllustration({Key? key, required this.assetPath, required this.title, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: 96,
              width: 96,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              summary,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ));
  }
}
