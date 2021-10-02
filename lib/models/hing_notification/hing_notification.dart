import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/object_id/object_id.dart';
import 'package:hing/models/timestamp/timestamp.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hing_notification.g.dart';

@JsonSerializable()
@HiveType(typeId: kHingNotificationType)
class HingNotification {
  @HiveField(0)
  @JsonKey(name: '_id')
  final ObjectId id;
  @HiveField(1)
  @JsonKey(name: 'created_at')
  final Timestamp createdAt;
  @HiveField(2)
  @JsonKey(name: 'other_user')
  final HingUser otherUser;
  @HiveField(3)
  @JsonKey(name: 'type')
  final int notificationType;

  HingNotification(
      {required this.id,
      required this.createdAt,
      required this.otherUser,
      required this.notificationType});

  factory HingNotification.fromJson(Map<String, dynamic> json) =>
      _$HingNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$HingNotificationToJson(this);
}
