import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';

class EmptyIllustration extends StatelessWidget {
  const EmptyIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/empty_illustration.png',
              height: 96,
              width: 96,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              S.of(context).emptyTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              S.of(context).noRecipesFound,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ));
  }
}
