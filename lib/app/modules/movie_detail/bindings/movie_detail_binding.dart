import 'package:get/get.dart';
import 'package:movies_app/app/modules/movie_detail/controllers/movie_detail_controller.dart';
import 'package:movies_app/core/interceptors/add_to_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/fetch_movie_interactor.dart';
import 'package:movies_app/core/interceptors/is_in_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/remove_from_watchlist_interactor.dart';

class MovieDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MovieDetailController>(
      MovieDetailController(
        FetchMovieInteractor(Get.find()),
        AddToWatchlistInteractor(Get.find()),
        RemoveFromWatchlistInteractor(Get.find()),
        IsInWatchlistInteractor(Get.find()),
      ),
    );
  }
}
