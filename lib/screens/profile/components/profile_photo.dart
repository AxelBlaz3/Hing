import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/screens/components/user_placeholder.dart';

class ProfilePhoto extends StatefulWidget {
  final double? size;
  final HingUser user;
  const ProfilePhoto({Key? key, this.size, required this.user})
      : super(key: key);

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          height: widget.size ?? 72,
          width: widget.size ?? 72,
          imageUrl: '$kBaseUrl/${widget.user.image}',
          placeholder: (_, __) => UserPlaceholder(
            size: widget.size ?? 64,
            backgroundSize: 32,
          ),
          errorWidget: (_, __, ___) => UserPlaceholder(
            size: widget.size ?? 64,
            backgroundSize: 32,
          ),
        ));
  }
}
