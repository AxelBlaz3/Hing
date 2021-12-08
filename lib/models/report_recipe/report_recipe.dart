import 'package:hing/models/object_id/object_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'report_recipe.g.dart';

@JsonSerializable()
class ReportRecipe {
  @JsonKey(name: 'report_reason')
  final String reportReason;
  final ObjectId recipeId;
  final ObjectId userId;

  ReportRecipe(
      {required this.reportReason,
      required this.recipeId,
      required this.userId});

  factory ReportRecipe.fromJson(Map<String, dynamic> json) =>
      _$ReportRecipeFromJson(json);

  Map<String, dynamic> toJson() => _$ReportRecipeToJson(this);
}
