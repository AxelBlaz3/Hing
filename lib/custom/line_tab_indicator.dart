import 'package:flutter/material.dart';
import 'package:hing/custom/line_tab_painter.dart';

class LineTabIndicator extends Decoration {
  final BoxPainter _painter = LineTabPainter();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}
