import 'package:hing/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
@HiveType(typeId: kIngredientType)
class Ingredient {
  @HiveField(0)
  String name;
  @HiveField(1)
  double quantity;
  @HiveField(2)
  String units;

  Ingredient({required this.name, required this.quantity, required this.units});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
