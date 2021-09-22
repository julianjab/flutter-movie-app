class LoadingMoviesException implements Exception {
  final String _error;
  LoadingMoviesException(this._error);

  @override
  String toString() => _error;
}
