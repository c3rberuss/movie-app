class MoviePoster {
  String title;
  String year;
  String id;
  String type;
  String poster;

  MoviePoster({this.title, this.year, this.id, this.type, this.poster});
}

class MoviePosterResponse {
  List<MoviePoster> search;
  bool success;
  int totalResults;
  String message;

  MoviePosterResponse({this.search, this.success, this.totalResults, this.message});
}
