import 'package:json_annotation/json_annotation.dart';

part 'report_recipe.g.dart';

@JsonSerializable()
class ReportRecipe {
  @JsonKey(name: 'report_reason')
  final String reportReason;
  final String recipeId;
  final String userId;

  ReportRecipe(
      {required this.reportReason,
      required this.recipeId,
      required this.userId});

  factory ReportRecipe.fromJson(Map<String, dynamic> json) =>
      _$ReportRecipeFromJson(json);

  Map<String, dynamic> toJson() => _$ReportRecipeToJson(this);
}
