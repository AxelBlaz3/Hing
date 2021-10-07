import 'package:hing/constants.dart';
import 'package:hing/models/object_id/object_id.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_notification.g.dart';

@JsonSerializable()
@HiveType(typeId: kRecipeNotificationType)
class RecipeNotification {
  @HiveField(0)
  @JsonKey(name: '_id')
  final ObjectId id;
  @HiveField(1)
  final String title;

  RecipeNotification({required this.id, required this.title});

  factory RecipeNotification.fromJson(Map<String, dynamic> json) =>
      _$RecipeNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeNotificationToJson(this);
}

@JsonSerializable()
@HiveType(typeId: kCommentNotificationType)
class CommentNotification {
  @HiveField(0)
  @JsonKey(name: '_id')
  final ObjectId id;
  @HiveField(1)
  @JsonKey(name: 'comment_id')
  final ObjectId? commentId;
  @HiveField(2)
  final String body;

  CommentNotification({required this.id, required this.body, this.commentId});

  factory CommentNotification.fromJson(Map<String, dynamic> json) =>
      _$CommentNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$CommentNotificationToJson(this);
}
