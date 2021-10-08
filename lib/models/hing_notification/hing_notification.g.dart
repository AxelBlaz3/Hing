// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hing_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HingNotificationAdapter extends TypeAdapter<HingNotification> {
  @override
  final int typeId = 7;

  @override
  HingNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HingNotification(
      id: fields[0] as ObjectId,
      createdAt: fields[1] as Timestamp,
      otherUser: fields[2] as HingUser,
      notificationType: fields[3] as int,
      recipeNotification: fields[4] as RecipeNotification?,
      commentNotification: fields[5] as CommentNotification?,
      replyNotification: fields[6] as CommentNotification?,
    );
  }

  @override
  void write(BinaryWriter writer, HingNotification obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.otherUser)
      ..writeByte(3)
      ..write(obj.notificationType)
      ..writeByte(4)
      ..write(obj.recipeNotification)
      ..writeByte(5)
      ..write(obj.commentNotification)
      ..writeByte(6)
      ..write(obj.replyNotification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HingNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HingNotification _$HingNotificationFromJson(Map<String, dynamic> json) {
  return HingNotification(
    id: ObjectId.fromJson(json['_id'] as Map<String, dynamic>),
    createdAt: Timestamp.fromJson(json['created_at'] as Map<String, dynamic>),
    otherUser: HingUser.fromJson(json['other_user'] as Map<String, dynamic>),
    notificationType: json['type'] as int,
    recipeNotification: json['recipe'] == null
        ? null
        : RecipeNotification.fromJson(json['recipe'] as Map<String, dynamic>),
    commentNotification: json['comment'] == null
        ? null
        : CommentNotification.fromJson(json['comment'] as Map<String, dynamic>),
    replyNotification: json['reply'] == null
        ? null
        : CommentNotification.fromJson(json['reply'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HingNotificationToJson(HingNotification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'created_at': instance.createdAt,
      'other_user': instance.otherUser,
      'type': instance.notificationType,
      'recipe': instance.recipeNotification,
      'comment': instance.commentNotification,
      'reply': instance.replyNotification,
    };
