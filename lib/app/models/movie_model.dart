import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/core/domain/movie.dart';
import 'package:movies_app/core/domain/rating.dart';

import 'rating_model.dart';

part 'movie_model.g.dart';

@JsonSerializable(nullable: true, createToJson: false)
class MovieModel extends Movie {
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "Year")
  String year;
  @JsonKey(name: "Rated")
  String rated;
  @JsonKey(name: "Released")
  String released;
  @JsonKey(name: "Runtime")
  String runtime;
  @JsonKey(name: "Genre")
  String genre;
  @JsonKey(name: "Director")
  String director;
  @JsonKey(name: "Writer")
  String writer;
  @JsonKey(name: "Actors")
  String actors;
  @JsonKey(name: "Plot")
  String plot;
  @JsonKey(name: "Language")
  String language;
  @JsonKey(name: "Country")
  String country;
  @JsonKey(name: "Awards")
  String awards;
  @JsonKey(name: "Poster")
  String poster;

  @JsonKey(name: "Metascore")
  String metascore;
  @JsonKey(name: "imdbRating")
  String imdbRating;
  @JsonKey(name: "imdbVotes")
  String votes;
  @JsonKey(name: "imdbID")
  String id;
  @JsonKey(name: "Type")
  String type;
  @JsonKey(name: "DVD")
  String dvd;
  @JsonKey(name: "BoxOffice")
  String boxOffice;
  @JsonKey(name: "Production")
  String production;
  @JsonKey(name: "Website")
  String website;
  @JsonKey(name: "Response")
  String message;

  @JsonKey(name: "Ratings")
  List<Rating> ratings;

  MovieModel(
      {this.rated,
      this.released,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.language,
      this.country,
      this.awards,
      this.metascore,
      this.imdbRating,
      this.votes,
      this.dvd,
      this.boxOffice,
      this.production,
      this.website,
      this.title,
      this.year,
      this.id,
      this.type,
      this.poster,
      List<RatingModel> ratings})
      : super(
          rated: rated,
          released: released,
          runtime: runtime,
          genre: genre,
          director: director,
          writer: writer,
          actors: actors,
          plot: plot,
          language: language,
          country: country,
          awards: awards,
          metascore: metascore,
          imdbRating: imdbRating,
          votes: votes,
          dvd: dvd,
          boxOffice: boxOffice,
          production: production,
          website: website,
          title: title,
          year: year,
          id: id,
          type: type,
          poster: poster,
          ratings: ratings,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);
}
