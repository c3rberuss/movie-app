import 'package:get/get.dart';
import 'package:movies_app/core/domain/movie.dart';
import 'package:movies_app/core/domain/movie_poster.dart';
import 'package:movies_app/core/domain/resource.dart';
import 'package:movies_app/core/interceptors/add_to_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/fetch_movie_interactor.dart';
import 'package:movies_app/core/interceptors/is_in_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/remove_from_watchlist_interactor.dart';

class MovieDetailController extends GetxController {
  final FetchMovieInteractor _fetchMovieInteractor;
  final AddToWatchlistInteractor _addToWatchlistInteractor;
  final RemoveFromWatchlistInteractor _removeFromWatchlistInteractor;
  final IsInWatchlistInteractor _isInWatchlistInteractor;

  Movie _movie;

  Movie get movie => _movie;

  Resource _status = Loading();

  Resource get status => _status;

  bool _isInWatchlist = false;

  bool get isInWatchlist => _isInWatchlist;

  MovieDetailController(
    this._fetchMovieInteractor,
    this._addToWatchlistInteractor,
    this._removeFromWatchlistInteractor,
    this._isInWatchlistInteractor,
  );

  Future<void> addToWatchlist(MoviePoster poster) async {
    await _addToWatchlistInteractor(poster);
  }

  Future<void> removeFromWatchlist(String movieId) async {
    await _removeFromWatchlistInteractor(movieId);
  }

  Future<void> fetchMovie(String movieId) async {
    final response = await _fetchMovieInteractor(movieId);
    _isInWatchlist = await _isInWatchlistInteractor(movieId);

    _movie = (response as Success<Movie>).data;
    _status = Success();
    update(['data']);
  }

  void toggleIsInWatchlist() {
    _isInWatchlist = !_isInWatchlist;
    update(['data']);
  }
}
