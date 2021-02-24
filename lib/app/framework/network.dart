import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Network {
  Dio _network;
  BaseOptions _options;
  DioCacheManager _cacheManager;

  Network(
      {@required String baseUrl,
      List<Interceptor> interceptors,
      bool cache = true,
      String apiKey,
      bool debugMode = true,
      DioCacheManager cacheManager}) {
    _options = new BaseOptions(
      baseUrl: baseUrl,
    );

    _cacheManager = cacheManager;

    _network = Dio(_options);

    if ((interceptors == null || interceptors.isEmpty)) {
      _network.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options) async {
            options.queryParameters['apikey'] = apiKey;

            return options;
          },
          onResponse: (Response response) {
            return response;
          },
        ),
      );
    } else if (interceptors != null && interceptors.isNotEmpty) {
      _network.interceptors.addAll(interceptors);
    }

    if (debugMode) {
      _network.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
        ),
      );
    }

    if (cache) _network.interceptors.add(_cacheManager.interceptor);
  }

  void addInterceptor(Interceptor interceptor) {
    _network.interceptors.add(interceptor);
  }

  Dio get instance => _network;

  Options cacheOptions({bool forceRefresh = false}) {
    return buildCacheOptions(const Duration(hours: 1), forceRefresh: forceRefresh);
  }

  void clearCache() {
    _cacheManager.clearAll();
  }
}
