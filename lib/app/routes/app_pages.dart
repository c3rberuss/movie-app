import 'package:get/get.dart';
import 'package:movies_app/app/modules/home/bindings/home_binding.dart';
import 'package:movies_app/app/modules/home/views/home_view.dart';
import 'package:movies_app/app/modules/movie_detail/bindings/movie_detail_binding.dart';
import 'package:movies_app/app/modules/movie_detail/views/movie_detail_view.dart';
import 'package:movies_app/app/modules/search/bindings/search_binding.dart';
import 'package:movies_app/app/modules/splash/bindings/splash_bindings.dart';
import 'package:movies_app/app/modules/splash/views/splash_view.dart';
import 'package:movies_app/app/modules/watchlist/bindings/watchlist_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      bindings: [
        HomeBinding(),
        WatchlistBinding(),
        SearchBinding(),
      ],
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => MovieDetailView(),
      binding: MovieDetailBinding(),
    ),
  ];
}
