import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/get.dart';
import 'package:movies_app/app/framework/api_data_source_impl.dart';
import 'package:movies_app/app/framework/database.dart';
import 'package:movies_app/app/framework/network.dart';
import 'package:movies_app/app/framework/watchlist_data_source_impl.dart';
import 'package:movies_app/app/modules/splash/controllers/splash_controller.dart';
import 'package:movies_app/core/data/api_data_source.dart';
import 'package:movies_app/core/data/api_repository.dart';
import 'package:movies_app/core/data/watchlist_data_source.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Db>(
      () => Db(),
      fenix: true,
    );

    Get.lazyPut<ApiDataSource>(
      () => ApiDataSourceImp(
        Network(
          baseUrl: ApiDataSourceImp.BASE_URL,
          apiKey: ApiDataSourceImp.API_KEY,
          cacheManager: DioCacheManager(
            CacheConfig(
              baseUrl: ApiDataSourceImp.BASE_URL,
              defaultMaxAge: Duration(days: 1),
            ),
          ),
        ),
      ),
    );

    Get.lazyPut<WatchlistDataSource>(
      () => WatchlistDataSourceImpl(Get.find()),
      fenix: true,
    );

    Get.lazyPut<ApiRepository>(
      () => ApiRepository(Get.find(), Get.find()),
      fenix: true,
    );

    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
