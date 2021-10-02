import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hing/theme/colors.dart';

class UserPlaceholder extends StatelessWidget {
  final double? size;
  final double? backgroundSize;
  const UserPlaceholder({Key? key, this.size, this.backgroundSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: backgroundSize ?? 24,
      child: SizedBox(
        height: size ?? 16,
        width: size ?? 16,
        child: SvgPicture.asset('assets/user_placeholder.svg'),
      ),
      backgroundColor: kPlaceholderBackgroundColor,
    );
  }
}
