import 'package:flutter/material.dart';
import 'package:hing/theme/colors.dart';

class LineTabPainter extends BoxPainter {
  final double radius = 8;
  final Paint _paint = Paint()..color = kPrimaryColor;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final RRect rrect = RRect.fromRectAndRadius(
        (offset + Offset(0, configuration.size!.height - 4)) &
            Size(configuration.size!.width, 4),
        Radius.circular(8));

    canvas.drawRRect(rrect, _paint);
  }
}
