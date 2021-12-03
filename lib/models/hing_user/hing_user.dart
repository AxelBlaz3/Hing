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
  String displayName;
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
  @HiveField(9)
  @JsonKey(name: 'firebase_token')
  String? firebaseToken;
  @HiveField(10)
  List<String>? myIngredients;
  @HiveField(11)
  List<String>? reportedRecipeIds;

  HingUser(
      {required this.id,
      required this.email,
      required this.displayName,
      this.accessToken,
      this.image,
      this.isFollowing,
      this.myIngredients,
      this.reportedRecipeIds});

  HingUser copy(
          {ObjectId? id,
          String? email,
          String? displayName,
          String? accessToken,
          String? image,
          bool? isFollowing,
          List<String>? myIngredients,
          List<String>? reportedRecipeIds}) =>
      HingUser(
          id: id ?? this.id,
          email: email ?? this.email,
          displayName: displayName ?? this.displayName,
          accessToken: accessToken ?? this.accessToken,
          image: image ?? this.image,
          isFollowing: isFollowing ?? this.isFollowing,
          myIngredients: myIngredients ?? this.myIngredients,
          reportedRecipeIds: reportedRecipeIds ?? this.reportedRecipeIds);

  factory HingUser.fromJson(Map<String, dynamic> json) =>
      _$HingUserFromJson(json);

  Map<String, dynamic> toJson() => _$HingUserToJson(this);
}
