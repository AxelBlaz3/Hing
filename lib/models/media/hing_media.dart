import 'package:hing/constants.dart';
import 'package:hing/models/object_id/object_id.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hing_media.g.dart';

@JsonSerializable()
@HiveType(typeId: kMediaType)
class HingMedia {
  @HiveField(0)
  @JsonKey(name: '_id')
  final ObjectId id;
  @HiveField(1)
  @JsonKey(name: 'media_type')
  final int mediaType;
  @HiveField(2)
  @JsonKey(name: 'media_path')
  final String mediaPath;
  @HiveField(3)
  @JsonKey(name: 'recipe_id')
  final ObjectId recipeId;

  const HingMedia(
      {required this.id,
      required this.mediaPath,
      required this.mediaType,
      required this.recipeId});

  factory HingMedia.fromJson(Map<String, dynamic> json) =>
      _$HingMediaFromJson(json);

  Map<String, dynamic> toJson() => _$HingMediaToJson(this);    
}
