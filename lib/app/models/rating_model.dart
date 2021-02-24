import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/core/domain/rating.dart';

part 'rating_model.g.dart';

@JsonSerializable(nullable: true, createToJson: false)
class RatingModel extends Rating {
  @JsonKey(name: "Source")
  String source;
  @JsonKey(name: "Value")
  String value;

  RatingModel({this.source, this.value});

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);
}
