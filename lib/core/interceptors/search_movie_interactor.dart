import '../data/api_repository.dart';
import '../domain/filter_type.dart';
import '../domain/movie_poster.dart';
import '../domain/resource.dart';

class SearchMovieInteractor {
  ApiRepository _repository;

  SearchMovieInteractor(this._repository);

  Future<Resource<MoviePosterResponse>> call(String movieTitle,
          [int page = 1, bool refresh = false, FilterType filterType = FilterType.all]) =>
      _repository.searchMovie(movieTitle, page, refresh, filterType);
}
