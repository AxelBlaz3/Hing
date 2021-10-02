import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ProfilePlaceholder extends StatelessWidget {
  const ProfilePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [8, 4],
      borderType: BorderType.RRect,
      radius: Radius.circular(16),
      child: Container(
        height: 96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        width: 96,
      ),
    );
  }
}
