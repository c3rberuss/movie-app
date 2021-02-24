abstract class Resource<T> {}

class Loading<T> implements Resource<T> {}

class Success<T> implements Resource<T> {
  final T data;

  Success([this.data]);
}

class Failure<T> implements Resource<T> {
  final Exception exception;

  Failure([this.exception]);
}
