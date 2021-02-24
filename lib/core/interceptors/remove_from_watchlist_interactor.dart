import '../data/api_repository.dart';

class RemoveFromWatchlistInteractor {
  final ApiRepository _repository;

  RemoveFromWatchlistInteractor(this._repository);

  Future<void> call(String movieId) => _repository.removeFromWatchlist(movieId);
}
