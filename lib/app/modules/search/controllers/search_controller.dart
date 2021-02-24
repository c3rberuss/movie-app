import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/core/domain/filter_type.dart';
import 'package:movies_app/core/domain/movie_poster.dart';
import 'package:movies_app/core/domain/resource.dart';
import 'package:movies_app/core/interceptors/is_in_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/remove_from_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/search_movie_interactor.dart';

class SearchController extends GetxController {
  final SearchMovieInteractor _searchMovieInteractor;
  final RemoveFromWatchlistInteractor _removeFromWatchlistInteractor;
  final IsInWatchlistInteractor _isInWatchlistInteractor;
  final TextEditingController textEditingController = TextEditingController();
  Resource _status = Success();

  RxBool _isLoading = false.obs;

  RxBool get isLoading => _isLoading;

  Resource get status => _status;
  final List<MoviePoster> data = [];
  String _prevQuery = "";
  Timer _debounce;
  int _posterSelected = -1;
  int get posterSelected => _posterSelected;

  RxDouble _height = (80.0).obs;
  RxDouble get height => _height;

  FilterType _filterType = FilterType.all;
  FilterType get currentFilter => _filterType;

  SearchController(
    this._searchMovieInteractor,
    this._removeFromWatchlistInteractor,
    this._isInWatchlistInteractor,
  );

  @override
  void onReady() {
    super.onReady();
    textEditingController.addListener(searchMovie);
  }

  Future<void> _fetchData(
    String query, {
    bool loadMore = false,
    bool refresh = false,
    FilterType filterType,
  }) async {
    Resource<MoviePosterResponse> result;

    if ((!refresh && !loadMore) || refresh) {
      if (!refresh) {
        _status = Loading();
        _isLoading.value = true;
      }

      _updateFilterType(filterType);

      result = await _searchMovieInteractor(query, 1, refresh, filterType);
    }

    if (result != null && result is Success<MoviePosterResponse>) {
      if (refresh) {
        data.clear();
        data.addAll(result.data.search);
        _status = Success();
        update(['data', 'loader']);
      } else {
        data.clear();
        data.addAll(result.data.search);
        _status = Success();
        update(['data', 'loader']);
      }
    } else if (result != null && result is Failure<MoviePosterResponse>) {
      _status = Failure();
      update(['data', "loader"]);
    }

    _isLoading.value = false;
  }

  Future<void> refreshData({FilterType filterType}) async {
    await searchMovie(refresh: true, filterType: filterType);
  }

  Future<void> changeFilter({FilterType filterType}) async {
    final query = textEditingController.text.toLowerCase();

    if ((query.isEmpty || query.length < 3) && (_prevQuery.isEmpty || _prevQuery.length < 3)) {
      _updateFilterType(filterType);
    } else {
      await refreshData(filterType: filterType);
    }
  }

  Future<void> searchMovie({bool refresh = false, FilterType filterType}) async {
    _updateFilterType(filterType);

    final query = textEditingController.text.toLowerCase();

    if (!refresh) {
      if (_debounce?.isActive ?? false) _debounce.cancel();

      _debounce = Timer(const Duration(milliseconds: 350), () async {
        if (query.isNotEmpty && query.length >= 3 && _prevQuery != query) {
          _prevQuery = query;
          await _fetchData(query, refresh: refresh, filterType: filterType);
        }
      });
    } else {
      await _fetchData(query.isEmpty ? _prevQuery : query,
          refresh: refresh, filterType: filterType);
    }
  }

  void clearInput() {
    textEditingController.clear();
  }

  Future<void> selectPoster(int index, String posterId) async {
    final isInWatchlist = await _isInWatchlistInteractor(posterId);

    if (isInWatchlist) {
      if (index == _posterSelected) {
        _posterSelected = -1;
      } else {
        _posterSelected = index;
      }

      update(['data']);
    }
  }

  Future<void> removeFromWatchList(String id) async {
    await _removeFromWatchlistInteractor(id);
    _posterSelected = -1;
    update(['data']);
  }

  void expandFilter() {
    _height.value = 170;
  }

  void collapseFilter() {
    _height.value = 80;
  }

  void _updateFilterType(FilterType filterType) {
    if (filterType != null) {
      _filterType = filterType;
    } else {
      filterType = _filterType;
    }
  }
}
