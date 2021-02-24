import 'package:movies_app/core/domain/resource.dart';

import '../data/api_repository.dart';
import '../domain/movie_poster.dart';

class RetrieveWatchlistInteractor {
  final ApiRepository _repository;

  RetrieveWatchlistInteractor(this._repository);

  Future<Resource<List<MoviePoster>>> call() => _repository.retrieveWatchlist();
}
