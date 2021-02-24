// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_poster_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviePosterModel _$MoviePosterModelFromJson(Map<String, dynamic> json) {
  return MoviePosterModel(
    title: json['Title'] as String,
    year: json['Year'] as String,
    id: json['imdbID'] as String,
    type: json['Type'] as String,
    poster: json['Poster'] as String,
  );
}

Map<String, dynamic> _$MoviePosterModelToJson(MoviePosterModel instance) => <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'imdbID': instance.id,
      'Type': instance.type,
      'Poster': instance.poster,
    };

MoviePostersResponseModel _$MoviePostersResponseModelFromJson(Map<String, dynamic> json) {
  return MoviePostersResponseModel(
    data: (json['Search'] as List)
        ?.map((e) => e == null ? null : MoviePosterModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    success: MoviePostersResponseModel._stringToBool(json['Response'] as String),
    totalResults: MoviePostersResponseModel._stringToInt(json['totalResults'] as String),
    message: json['Error'] as String,
  );
}
