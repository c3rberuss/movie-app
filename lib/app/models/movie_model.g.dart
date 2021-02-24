// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) {
  return MovieModel(
    rated: json['Rated'] as String,
    released: json['Released'] as String,
    runtime: json['Runtime'] as String,
    genre: json['Genre'] as String,
    director: json['Director'] as String,
    writer: json['Writer'] as String,
    actors: json['Actors'] as String,
    plot: json['Plot'] as String,
    language: json['Language'] as String,
    country: json['Country'] as String,
    awards: json['Awards'] as String,
    metascore: json['Metascore'] as String,
    imdbRating: json['imdbRating'] as String,
    votes: json['imdbVotes'] as String,
    dvd: json['DVD'] as String,
    boxOffice: json['BoxOffice'] as String,
    production: json['Production'] as String,
    website: json['Website'] as String,
    title: json['Title'] as String,
    year: json['Year'] as String,
    id: json['imdbID'] as String,
    type: json['Type'] as String,
    poster: json['Poster'] as String,
    ratings: (json['Ratings'] as List)
        ?.map((e) => e == null ? null : RatingModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..message = json['Response'] as String;
}
