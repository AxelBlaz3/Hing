import 'package:hing/constants.dart';
import 'package:hing/models/object_id/object_id.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hing_user.g.dart';

@JsonSerializable()
@HiveType(typeId: kHingUserType)
class HingUser {
  @HiveField(0)
  @JsonKey(name: '_id')
  final ObjectId id;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  String? image;
  @HiveField(3)
  @JsonKey(name: 'display_name')
  final String displayName;
  @HiveField(4)
  final String? accessToken;
  @HiveField(5)
  @JsonKey(name: 'is_following')
  bool? isFollowing = false;
  @HiveField(6)
  @JsonKey(name: 'posts_count')
  int? postsCount = 0;
  @HiveField(7)
  @JsonKey(name: 'following_count')
  int? followingCount = 0;
  @HiveField(8)
  @JsonKey(name: 'followers_count')
  int? followersCount = 0;

  HingUser(
      {required this.id,
      required this.email,
      required this.displayName,
      this.accessToken,
      this.image,
      this.isFollowing});

  factory HingUser.fromJson(Map<String, dynamic> json) =>
      _$HingUserFromJson(json);

  Map<String, dynamic> toJson() => _$HingUserToJson(this);
}
