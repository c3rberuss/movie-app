import '../domain/movie_poster.dart';
import '../domain/resource.dart';

abstract class WatchlistDataSource {
  Future<void> addToWatchlist(MoviePoster poster);

  Future<void> removeFromWatchlist(String movieId);

  Future<Resource<List<MoviePoster>>> retrieveWatchlist();

  Future<bool> isInWatchlist(String movieId);
}
