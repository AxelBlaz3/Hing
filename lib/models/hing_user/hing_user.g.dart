// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hing_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HingUserAdapter extends TypeAdapter<HingUser> {
  @override
  final int typeId = 1;

  @override
  HingUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HingUser(
      id: fields[0] as ObjectId,
      email: fields[1] as String?,
      displayName: fields[3] as String,
      accessToken: fields[4] as String?,
      image: fields[2] as String?,
      isFollowing: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, HingUser obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.displayName)
      ..writeByte(4)
      ..write(obj.accessToken)
      ..writeByte(5)
      ..write(obj.isFollowing);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HingUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HingUser _$HingUserFromJson(Map<String, dynamic> json) {
  return HingUser(
    id: ObjectId.fromJson(json['_id'] as Map<String, dynamic>),
    email: json['email'] as String?,
    displayName: json['display_name'] as String,
    accessToken: json['accessToken'] as String?,
    image: json['image'] as String?,
    isFollowing: json['is_following'] as bool?,
  );
}

Map<String, dynamic> _$HingUserToJson(HingUser instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'image': instance.image,
      'display_name': instance.displayName,
      'accessToken': instance.accessToken,
      'is_following': instance.isFollowing,
    };
