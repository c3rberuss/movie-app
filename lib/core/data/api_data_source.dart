import '../domain/filter_type.dart';
import '../domain/movie.dart';
import '../domain/movie_poster.dart';
import '../domain/resource.dart';

abstract class ApiDataSource {
  Future<Resource<MoviePosterResponse>> searchMovie(String movieTitle,
      [int page = 1, bool refresh = false, FilterType filterType = FilterType.all]);

  Future<Resource<Movie>> fetchMovie(String movieId, [bool refresh = false]);
}
