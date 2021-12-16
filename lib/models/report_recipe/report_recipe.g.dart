// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportRecipe _$ReportRecipeFromJson(Map<String, dynamic> json) {
  return ReportRecipe(
    reportReason: json['report_reason'] as String,
    recipeId: json['recipeId'] as String,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$ReportRecipeToJson(ReportRecipe instance) =>
    <String, dynamic>{
      'report_reason': instance.reportReason,
      'recipeId': instance.recipeId,
      'userId': instance.userId,
    };
