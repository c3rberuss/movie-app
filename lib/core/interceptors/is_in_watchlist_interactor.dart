import '../data/api_repository.dart';

class IsInWatchlistInteractor {
  final ApiRepository _repository;

  IsInWatchlistInteractor(this._repository);

  Future<bool> call(String movieId) => _repository.isInWatchlist(movieId);
}
