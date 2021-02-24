import 'package:get/get.dart';
import 'package:movies_app/core/domain/movie_poster.dart';
import 'package:movies_app/core/domain/resource.dart';
import 'package:movies_app/core/interceptors/remove_from_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/retrieve_watchlist_interactor.dart';

class WatchlistController extends GetxController {
  final RetrieveWatchlistInteractor _getWatchlist;
  final RemoveFromWatchlistInteractor _removeFromWatchlistInteractor;
  Resource _status = Success();

  Resource get status => _status;
  final List<MoviePoster> data = [];

  int _posterSelected = -1;

  int get posterSelected => _posterSelected;

  WatchlistController(this._getWatchlist, this._removeFromWatchlistInteractor);

  @override
  void onInit() {
    super.onInit();
    fetchWatchlist();
  }

  Future<void> fetchWatchlist({bool refresh = true}) async {
    Resource<List<MoviePoster>> result;

    result = await _getWatchlist();

    if (result != null && result is Success<List<MoviePoster>>) {
      if (refresh) {
        data.clear();
        data.addAll(result.data);
        _status = Success();
        update(['builder']);
      } else {
        data.clear();
        data.addAll(result.data);
        _status = Success();
        update(['builder']);
      }
    } else if (result != null && result is Failure) {
      _status = Failure();
      update(['builder']);
    }
  }

  Future<void> refreshData() async {
    await fetchWatchlist(refresh: true);
  }

  Future<void> selectPoster(int index, String posterId) async {
    if (index == _posterSelected) {
      _posterSelected = -1;
    } else {
      _posterSelected = index;
    }

    update(['data']);
  }

  Future<void> removeFromWatchList(String id) async {
    await _removeFromWatchlistInteractor(id);
    _posterSelected = -1;
    update(['data']);
  }
}
