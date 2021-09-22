import 'package:hing/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timestamp.g.dart';

@JsonSerializable()
@HiveType(typeId: kTimestampType)
class Timestamp {
  @HiveField(0)
  @JsonKey(name: '\$date')
  final int date;

  Timestamp({required this.date});

  factory Timestamp.fromJson(Map<String, dynamic> json) =>
      _$TimestampFromJson(json);

  Map<String, dynamic> toJson() => _$TimestampToJson(this);
}
