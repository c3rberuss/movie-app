import '../domain/filter_type.dart';
import '../domain/movie.dart';
import '../domain/movie_poster.dart';
import '../domain/resource.dart';
import 'api_data_source.dart';
import 'watchlist_data_source.dart';

class ApiRepository {
  ApiDataSource _dataSource;
  WatchlistDataSource _watchlistDataSource;

  ApiRepository(this._dataSource, this._watchlistDataSource);

  Future<Resource<MoviePosterResponse>> searchMovie(String movieTitle,
          [int page = 1, bool refresh = false, FilterType filterType = FilterType.all]) =>
      _dataSource.searchMovie(movieTitle, page, refresh, filterType);

  Future<Resource<Movie>> fetchMovie(String movieId, [bool refresh = false]) =>
      _dataSource.fetchMovie(movieId, refresh);

  Future<void> addToWatchlist(MoviePoster poster) => _watchlistDataSource.addToWatchlist(poster);

  Future<void> removeFromWatchlist(String movieId) =>
      _watchlistDataSource.removeFromWatchlist(movieId);

  Future<Resource<List<MoviePoster>>> retrieveWatchlist() =>
      _watchlistDataSource.retrieveWatchlist();

  Future<bool> isInWatchlist(String movieId) => _watchlistDataSource.isInWatchlist(movieId);
}
