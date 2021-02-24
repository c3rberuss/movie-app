class Response<T> {
  T data;
  bool success;
  int totalResults;
  String message;

  Response({this.data, this.success, this.totalResults, this.message});
}
