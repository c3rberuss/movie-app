import 'package:movies_app/app/framework/database.dart';
import 'package:movies_app/app/models/movie_poster_model.dart';
import 'package:movies_app/core/data/watchlist_data_source.dart';
import 'package:movies_app/core/domain/movie_poster.dart';
import 'package:movies_app/core/domain/resource.dart';
import 'package:sqflite/sqflite.dart';

class WatchlistDataSourceImpl implements WatchlistDataSource {
  final Db _db;

  WatchlistDataSourceImpl(this._db);

  @override
  Future<void> addToWatchlist(MoviePoster poster) async {
    if (_db.database != null && _db.database.isOpen) {
      final parsed = MoviePosterModel(
        title: poster.title,
        year: poster.year,
        id: poster.id,
        type: poster.type,
        poster: poster.poster,
      );

      await _db.database.insert(
        "watchlist",
        parsed.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<void> removeFromWatchlist(String movieId) async {
    if (_db.database != null && _db.database.isOpen) {
      await _db.database.delete(
        "watchlist",
        where: "imdbID = ?",
        whereArgs: [movieId],
      );
    }
  }

  @override
  Future<Resource<List<MoviePoster>>> retrieveWatchlist() async {
    if (_db.database != null && _db.database.isOpen) {
      final List<Map<String, dynamic>> posters = await _db.database.query('watchlist');

      return Success(
        List.generate(
          posters.length,
          (i) => MoviePosterModel.fromJson(posters[i]),
        ),
      );
    }
    return Success([]);
  }

  @override
  Future<bool> isInWatchlist(String movieId) async {
    if (_db.database != null && _db.database.isOpen) {
      final count = Sqflite.firstIntValue(
        await _db.database.rawQuery(
          "SELECT COUNT(*) FROM watchlist where imdbID = ?",
          [movieId],
        ),
      );

      return count == 1;
    }

    return false;
  }
}
