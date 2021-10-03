import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/object_id/object_id.dart';
import 'package:hing/models/timestamp/timestamp.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
@HiveType(typeId: kCommentType)
class Comment {
  @HiveField(0)
  @JsonKey(name: '_id')
  final ObjectId id;
  @HiveField(1)
  final String body;
  @HiveField(2)
  @JsonKey(name: 'is_liked')
  bool isLiked;
  @HiveField(3)
  @JsonKey(name: 'likes_count')
  int likesCount;
  @HiveField(4)
  @JsonKey(name: 'replies_count')
  int repliesCount;
  @HiveField(5)
  @JsonKey(name: 'recipe_id')
  final ObjectId recipeId;
  @HiveField(6)
  final HingUser user;
  @HiveField(7)
  @JsonKey(name: 'created_at')
  final Timestamp createdAt;
  @HiveField(8)
  @JsonKey(name: 'comment_id')
  final ObjectId? commentId;

  Comment(
      {required this.id,
      required this.body,
      required this.isLiked,
      required this.likesCount,
      required this.repliesCount,
      required this.recipeId,
      required this.user,
      required this.createdAt,
      this.commentId});

  //Comment1();

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
