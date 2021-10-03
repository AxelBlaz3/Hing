// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final int typeId = 5;

  @override
  Comment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comment(
      id: fields[0] as ObjectId,
      body: fields[1] as String,
      isLiked: fields[2] as bool,
      likesCount: fields[3] as int,
      repliesCount: fields[4] as int,
      recipeId: fields[5] as ObjectId,
      user: fields[6] as HingUser,
      createdAt: fields[7] as Timestamp,
      commentId: fields[8] as ObjectId?,
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.isLiked)
      ..writeByte(3)
      ..write(obj.likesCount)
      ..writeByte(4)
      ..write(obj.repliesCount)
      ..writeByte(5)
      ..write(obj.recipeId)
      ..writeByte(6)
      ..write(obj.user)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.commentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: ObjectId.fromJson(json['_id'] as Map<String, dynamic>),
    body: json['body'] as String,
    isLiked: json['is_liked'] as bool,
    likesCount: json['likes_count'] as int,
    repliesCount: json['replies_count'] as int,
    recipeId: ObjectId.fromJson(json['recipe_id'] as Map<String, dynamic>),
    user: HingUser.fromJson(json['user'] as Map<String, dynamic>),
    createdAt: Timestamp.fromJson(json['created_at'] as Map<String, dynamic>),
    commentId: json['comment_id'] == null
        ? null
        : ObjectId.fromJson(json['comment_id'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      '_id': instance.id,
      'body': instance.body,
      'is_liked': instance.isLiked,
      'likes_count': instance.likesCount,
      'replies_count': instance.repliesCount,
      'recipe_id': instance.recipeId,
      'user': instance.user,
      'created_at': instance.createdAt,
      'comment_id': instance.commentId,
    };
