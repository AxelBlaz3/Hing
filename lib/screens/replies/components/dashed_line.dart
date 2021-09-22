import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: DottedLine(
          dashLength: 16,
          dashColor: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
        ));
  }
}
