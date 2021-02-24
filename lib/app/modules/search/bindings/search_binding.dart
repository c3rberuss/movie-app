import 'package:get/get.dart';
import 'package:movies_app/app/modules/search/controllers/search_controller.dart';
import 'package:movies_app/core/interceptors/is_in_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/remove_from_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/search_movie_interactor.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchController>(
      SearchController(
        SearchMovieInteractor(
          Get.find(),
        ),
        RemoveFromWatchlistInteractor(
          Get.find(),
        ),
        IsInWatchlistInteractor(
          Get.find(),
        ),
      ),
    );
  }
}
