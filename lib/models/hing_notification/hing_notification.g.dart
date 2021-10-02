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
    );
  }

  @override
  void write(BinaryWriter writer, HingNotification obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.otherUser)
      ..writeByte(3)
      ..write(obj.notificationType);
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
  );
}

Map<String, dynamic> _$HingNotificationToJson(HingNotification instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'created_at': instance.createdAt,
      'other_user': instance.otherUser,
      'type': instance.notificationType,
    };
