// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timestamp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimestampAdapter extends TypeAdapter<Timestamp> {
  @override
  final int typeId = 6;

  @override
  Timestamp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Timestamp(
      date: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Timestamp obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimestampAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timestamp _$TimestampFromJson(Map<String, dynamic> json) {
  return Timestamp(
    date: json[r'$date'] as int,
  );
}

Map<String, dynamic> _$TimestampToJson(Timestamp instance) => <String, dynamic>{
      r'$date': instance.date,
    };
