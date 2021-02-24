import 'package:dio/dio.dart';
import 'package:movies_app/app/framework/network.dart';
import 'package:movies_app/app/models/movie_model.dart';
import 'package:movies_app/app/models/movie_poster_model.dart';
import 'package:movies_app/core/data/api_data_source.dart';
import 'package:movies_app/core/domain/filter_type.dart';
import 'package:movies_app/core/domain/movie.dart';
import 'package:movies_app/core/domain/movie_poster.dart';
import 'package:movies_app/core/domain/resource.dart';

class ApiDataSourceImp implements ApiDataSource {
  final Network _network;
  static const String BASE_URL = "http://www.omdbapi.com";
  static const String API_KEY = "fa6599ee";

  ApiDataSourceImp(this._network);

  @override
  Future<Resource<Movie>> fetchMovie(String movieId, [bool refresh = false]) async {
    try {
      final response = await _network.instance.get("/",
          queryParameters: {
            "i": movieId,
          },
          options: _network.cacheOptions(forceRefresh: refresh));

      final parsedData = MovieModel.fromJson(response.data);

      if (response.statusCode == 200) {
        return Success(parsedData);
      }

      return Failure(Exception(parsedData.message));
    } on DioError catch (error) {
      return Failure(error);
    }
  }

  @override
  Future<Resource<MoviePosterResponse>> searchMovie(String movieTitle,
      [int page = 1, bool refresh = false, FilterType filterType = FilterType.all]) async {
    try {
      final params = {
        "s": movieTitle,
        "page": page,
      };

      if (filterType == FilterType.movies) {
        params['type'] = 'movie';
      } else if (filterType == FilterType.series) {
        params['type'] = 'series';
      } else if (filterType == FilterType.episodes) {
        params['type'] = 'episode';
      }

      final response = await _network.instance.get(
        "/",
        queryParameters: params,
        options: _network.cacheOptions(forceRefresh: refresh),
      );

      final parsedData = MoviePostersResponseModel.fromJson(response.data);
      parsedData.search = parsedData.data;

      if (parsedData.success) {
        return Success(parsedData);
      }

      return Failure(Exception(parsedData.message));
    } on DioError catch (error) {
      return Failure(error);
    }
  }
}
