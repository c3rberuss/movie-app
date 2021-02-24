import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_app/app/modules/search/controllers/search_controller.dart';
import 'package:movies_app/core/data/api_data_source.dart';
import 'package:movies_app/core/data/api_repository.dart';
import 'package:movies_app/core/data/watchlist_data_source.dart';
import 'package:movies_app/core/domain/filter_type.dart';
import 'package:movies_app/core/interceptors/is_in_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/remove_from_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/search_movie_interactor.dart';

class ApiDataSourceMock extends Mock implements ApiDataSource {}

class WatchlistDataSourceMock extends Mock implements WatchlistDataSource {}

void main() {
  final ApiDataSourceMock apiDataSource = ApiDataSourceMock();
  final WatchlistDataSourceMock watchlistDataSource = WatchlistDataSourceMock();
  final repository = ApiRepository(apiDataSource, watchlistDataSource);

  final isInWatchlist = IsInWatchlistInteractor(repository);
  final removeFromWatchlist = RemoveFromWatchlistInteractor(repository);
  final search = SearchMovieInteractor(repository);

  group("Success", () {
    final searchController = SearchController(search, removeFromWatchlist, isInWatchlist);

    test("Expand filter panel", () {
      searchController.expandFilter();
      expect(searchController.height.value, 170);
    });

    test("Collapse filter panel", () {
      searchController.collapseFilter();
      expect(searchController.height.value, 80);
    });

    test("Change filter", () {
      searchController.changeFilter(filterType: FilterType.episodes);
      expect(searchController.currentFilter, FilterType.episodes);

      searchController.changeFilter();
      expect(searchController.currentFilter, FilterType.episodes);

      searchController.changeFilter(filterType: FilterType.movies);
      expect(searchController.currentFilter, FilterType.movies);
    });
  });
}
