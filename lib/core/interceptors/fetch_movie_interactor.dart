import '../data/api_repository.dart';
import '../domain/movie.dart';
import '../domain/resource.dart';

class FetchMovieInteractor {
  ApiRepository _repository;

  FetchMovieInteractor(this._repository);

  Future<Resource<Movie>> call(String movieId, [bool refresh = false]) =>
      _repository.fetchMovie(movieId, refresh);
}
