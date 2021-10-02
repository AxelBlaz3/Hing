import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  final double? size;
  final double? strokeWidth;
  const CircularIndicator({Key? key, this.size, this.strokeWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size ?? 16,
        width: size ?? 16,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth ?? 3.0,
        ));
  }
}
