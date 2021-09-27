import 'package:flutter/material.dart';

class ProfilePhoto extends StatefulWidget {
  final double? size;
  const ProfilePhoto({Key? key, this.size}) : super(key: key);

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/sample_post_image.jpg',
            height: widget.size ?? 72,
            width: widget.size ?? 72,
            fit: BoxFit.cover,
          )),
    );
  }
}
