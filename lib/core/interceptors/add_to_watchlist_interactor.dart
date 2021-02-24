import '../data/api_repository.dart';
import '../domain/movie_poster.dart';

class AddToWatchlistInteractor {
  final ApiRepository _repository;

  AddToWatchlistInteractor(this._repository);

  Future<void> call(MoviePoster poster) => _repository.addToWatchlist(poster);
}
