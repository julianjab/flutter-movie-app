import 'package:equatable/equatable.dart';
import 'package:flutter_movies_app/src/domain/entities/movie.dart';

class MoviesState extends Equatable {
  const MoviesState(this._movies);

  final List<Movie> _movies;

  List<Movie> get movies => _movies;

  @override
  List<Object?> get props => [_movies];
}

class LoadingMovies extends MoviesState {
  const LoadingMovies(List<Movie> movies) : super(movies);
}

class MoviesLoaded extends MoviesState {
  const MoviesLoaded(List<Movie> movies) : super(movies);
}

class LoadingMoviesError extends MoviesState {
  final String message;

  const LoadingMoviesError(
    List<Movie> movies,
    this.message,
  ) : super(movies);

  @override
  List<Object?> get props => [message, ...super.props];
}
