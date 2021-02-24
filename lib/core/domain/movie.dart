import 'movie_poster.dart';
import 'rating.dart';
import 'response.dart';

class Movie extends MoviePoster {
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String metascore;
  String imdbRating;
  String votes;
  String dvd;
  String boxOffice;
  String production;
  String website;
  String message;
  List<Rating> ratings;

  Movie({
    this.rated,
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
    this.ratings,
    this.message,
    String title,
    String year,
    String id,
    String type,
    String poster,
  }) : super(
          title: title,
          year: year,
          id: id,
          type: type,
          poster: poster,
        );
}

class MovieResponse extends Response<Movie> {
  MovieResponse(
    Movie movie,
    bool success,
    int totalResults,
    String message,
  ) : super(
          data: movie,
          success: success,
          totalResults: totalResults,
          message: message,
        );
}
