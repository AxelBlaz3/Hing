import 'package:flutter/material.dart';
import 'package:hing/generated/l10n.dart';

class ErrorIllustration extends StatelessWidget {
  const ErrorIllustration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sentiment_dissatisfied_rounded,
                color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                size: 48),
            SizedBox(
              height: 8,
            ),
            Text(
              S.of(context).somethingWentWrong,
              style:
                  Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 12),
            )
          ],
        ));
  }
}
