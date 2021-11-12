import 'package:hing/constants.dart';
import 'package:hing/models/hing_user/hing_user.dart';
import 'package:hing/models/ingredient/ingredient.dart';
import 'package:hing/models/media/hing_media.dart';
import 'package:hing/models/object_id/object_id.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'recipe.g.dart';

@JsonSerializable()
@HiveType(typeId: kRecipeType)
class Recipe {
  @HiveField(0)
  @JsonKey(name: '_id')
  final ObjectId id;
  @HiveField(1)
  final int category;
  @HiveField(2)
  final List<Ingredient> ingredients;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final List<HingMedia> media;
  @HiveField(6)
  final HingUser user;
  @HiveField(7)
  @JsonKey(name: 'likes_count')
  int likesCount;
  @HiveField(8)
  @JsonKey(name: 'comments_count')
  int commentsCount;
  @HiveField(9)
  @JsonKey(name: 'is_favorite')
  bool isFavorite = false;
  @HiveField(10)
  @JsonKey(name: 'is_liked')
  bool? isLiked = false;
  @HiveField(11)
  @JsonKey(name: 'my_ingredients')
  List<String>? myIngredients;

  Recipe(
      {required this.id,
      required this.category,
      required this.description,
      required this.ingredients,
      required this.media,
      required this.title,
      required this.user,
      required this.likesCount,
      required this.isFavorite,
      required this.isLiked,
      required this.commentsCount,
      this.myIngredients = const <String>[]});

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

enum RecipeMediaType { image, video }
