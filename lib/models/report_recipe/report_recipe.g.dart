// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportRecipe _$ReportRecipeFromJson(Map<String, dynamic> json) {
  return ReportRecipe(
    reportReason: json['report_reason'] as String,
    recipeId: ObjectId.fromJson(json['recipeId'] as Map<String, dynamic>),
    userId: ObjectId.fromJson(json['userId'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReportRecipeToJson(ReportRecipe instance) =>
    <String, dynamic>{
      'report_reason': instance.reportReason,
      'recipeId': instance.recipeId,
      'userId': instance.userId,
    };
