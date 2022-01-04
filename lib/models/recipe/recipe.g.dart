// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 3;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as ObjectId,
      category: fields[1] as int,
      description: fields[4] as String,
      ingredients: (fields[2] as List).cast<Ingredient>(),
      media: (fields[5] as List).cast<HingMedia>(),
      title: fields[3] as String,
      user: fields[6] as HingUser,
      likesCount: fields[7] as int,
      isFavorite: fields[9] as bool,
      isLiked: fields[10] as bool?,
      commentsCount: fields[8] as int,
      myIngredients: (fields[11] as List?)?.cast<String>(),
    )..createdAt = (fields[12] as Map?)?.cast<dynamic, dynamic>();
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.ingredients)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.media)
      ..writeByte(6)
      ..write(obj.user)
      ..writeByte(7)
      ..write(obj.likesCount)
      ..writeByte(8)
      ..write(obj.commentsCount)
      ..writeByte(9)
      ..write(obj.isFavorite)
      ..writeByte(10)
      ..write(obj.isLiked)
      ..writeByte(11)
      ..write(obj.myIngredients)
      ..writeByte(12)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
    id: ObjectId.fromJson(json['_id'] as Map<String, dynamic>),
    category: json['category'] as int,
    description: json['description'] as String,
    ingredients: (json['ingredients'] as List<dynamic>)
        .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
        .toList(),
    media: (json['media'] as List<dynamic>)
        .map((e) => HingMedia.fromJson(e as Map<String, dynamic>))
        .toList(),
    title: json['title'] as String,
    user: HingUser.fromJson(json['user'] as Map<String, dynamic>),
    likesCount: json['likes_count'] as int,
    isFavorite: json['is_favorite'] as bool,
    isLiked: json['is_liked'] as bool?,
    commentsCount: json['comments_count'] as int,
    myIngredients: (json['my_ingredients'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
  )..createdAt = json['created_at'] as Map<String, dynamic>?;
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      '_id': instance.id,
      'category': instance.category,
      'ingredients': instance.ingredients,
      'title': instance.title,
      'description': instance.description,
      'media': instance.media,
      'user': instance.user,
      'likes_count': instance.likesCount,
      'comments_count': instance.commentsCount,
      'is_favorite': instance.isFavorite,
      'is_liked': instance.isLiked,
      'my_ingredients': instance.myIngredients,
      'created_at': instance.createdAt,
    };
