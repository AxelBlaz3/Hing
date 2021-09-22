// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hing_media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HingMediaAdapter extends TypeAdapter<HingMedia> {
  @override
  final int typeId = 4;

  @override
  HingMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HingMedia(
      id: fields[0] as ObjectId,
      mediaPath: fields[2] as String,
      mediaType: fields[1] as int,
      recipeId: fields[3] as ObjectId,
    );
  }

  @override
  void write(BinaryWriter writer, HingMedia obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mediaType)
      ..writeByte(2)
      ..write(obj.mediaPath)
      ..writeByte(3)
      ..write(obj.recipeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HingMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HingMedia _$HingMediaFromJson(Map<String, dynamic> json) {
  return HingMedia(
    id: ObjectId.fromJson(json['_id'] as Map<String, dynamic>),
    mediaPath: json['media_path'] as String,
    mediaType: json['media_type'] as int,
    recipeId: ObjectId.fromJson(json['recipe_id'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HingMediaToJson(HingMedia instance) => <String, dynamic>{
      '_id': instance.id,
      'media_type': instance.mediaType,
      'media_path': instance.mediaPath,
      'recipe_id': instance.recipeId,
    };
