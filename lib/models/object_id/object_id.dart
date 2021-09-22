import 'package:hing/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'object_id.g.dart';

@HiveType(typeId: kObjectIdType)
@JsonSerializable()
class ObjectId {
  @HiveField(0)
  @JsonKey(name: '\$oid')
  final String oid;

  const ObjectId({required this.oid});

  factory ObjectId.fromJson(Map<String, dynamic> json) => _$ObjectIdFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectIdToJson(this);
}
