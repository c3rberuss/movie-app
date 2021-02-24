import 'package:get/get.dart';
import 'package:movies_app/app/modules/watchlist/controllers/watchlist_controller.dart';
import 'package:movies_app/core/interceptors/remove_from_watchlist_interactor.dart';
import 'package:movies_app/core/interceptors/retrieve_watchlist_interactor.dart';

class WatchlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WatchlistController>(
      WatchlistController(
        RetrieveWatchlistInteractor(
          Get.find(),
        ),
        RemoveFromWatchlistInteractor(
          Get.find(),
        ),
      ),
    );
  }
}
