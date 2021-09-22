// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_id.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObjectIdAdapter extends TypeAdapter<ObjectId> {
  @override
  final int typeId = 0;

  @override
  ObjectId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ObjectId(
      oid: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ObjectId obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.oid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjectIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectId _$ObjectIdFromJson(Map<String, dynamic> json) {
  return ObjectId(
    oid: json[r'$oid'] as String,
  );
}

Map<String, dynamic> _$ObjectIdToJson(ObjectId instance) => <String, dynamic>{
      r'$oid': instance.oid,
    };
