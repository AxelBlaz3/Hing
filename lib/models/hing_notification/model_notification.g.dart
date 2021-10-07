// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeNotificationAdapter extends TypeAdapter<RecipeNotification> {
  @override
  final int typeId = 9;

  @override
  RecipeNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeNotification(
      id: fields[0] as ObjectId,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeNotification obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CommentNotificationAdapter extends TypeAdapter<CommentNotification> {
  @override
  final int typeId = 8;

  @override
  CommentNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentNotification(
      id: fields[0] as ObjectId,
      body: fields[2] as String,
      commentId: fields[1] as ObjectId?,
    );
  }

  @override
  void write(BinaryWriter writer, CommentNotification obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.commentId)
      ..writeByte(2)
      ..write(obj.body);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeNotification _$RecipeNotificationFromJson(Map<String, dynamic> json) {
  return RecipeNotification(
    id: ObjectId.fromJson(json['_id'] as Map<String, dynamic>),
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$RecipeNotificationToJson(RecipeNotification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
    };

CommentNotification _$CommentNotificationFromJson(Map<String, dynamic> json) {
  return CommentNotification(
    id: ObjectId.fromJson(json['_id'] as Map<String, dynamic>),
    body: json['body'] as String,
    commentId: json['comment_id'] == null
        ? null
        : ObjectId.fromJson(json['comment_id'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentNotificationToJson(
        CommentNotification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'comment_id': instance.commentId,
      'body': instance.body,
    };
