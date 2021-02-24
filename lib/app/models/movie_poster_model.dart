import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/core/domain/movie_poster.dart';

part 'movie_poster_model.g.dart';

@JsonSerializable(nullable: true, createToJson: true)
class MoviePosterModel extends MoviePoster {
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "Year")
  String year;
  @JsonKey(name: "imdbID")
  String id;
  @JsonKey(name: "Type")
  String type;
  @JsonKey(name: "Poster")
  String poster;

  MoviePosterModel({this.title, this.year, this.id, this.type, this.poster})
      : super(
          title: title,
          year: year,
          id: id,
          type: type,
          poster: poster,
        );

  factory MoviePosterModel.fromJson(Map<String, dynamic> json) => _$MoviePosterModelFromJson(json);

  Map<String, dynamic> toJson() => _$MoviePosterModelToJson(this);
}

@JsonSerializable(nullable: true, createToJson: false)
class MoviePostersResponseModel extends MoviePosterResponse {
  @JsonKey(name: "Response", fromJson: _stringToBool)
  bool success;

  @JsonKey(name: "totalResults", fromJson: _stringToInt)
  int totalResults;

  @JsonKey(ignore: true)
  List<MoviePoster> search;

  @JsonKey(name: "Search")
  List<MoviePosterModel> data;

  @JsonKey(name: "Error")
  String message;

  MoviePostersResponseModel({this.search, this.data, this.success, this.totalResults, this.message})
      : super(
          search: search,
          success: success,
          totalResults: totalResults,
          message: message,
        );

  factory MoviePostersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MoviePostersResponseModelFromJson(json);

  static int _stringToInt(String number) {
    return number != null ? int.parse(number) : 0;
  }

  static bool _stringToBool(String result) {
    return result == "True";
  }
}
