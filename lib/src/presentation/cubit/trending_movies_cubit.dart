import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/src/domain/entities/movie.dart';
import 'package:flutter_movies_app/src/domain/usecases/get_movies.dart';
import 'package:flutter_movies_app/src/presentation/cubit/movies_state.dart';

class TrendingMoviesCubit extends Cubit<MoviesState> {
  final GetMovies trendingMovies;

  final List<Movie> _movies = [];
  int _page = 1;

  TrendingMoviesCubit(this.trendingMovies) : super(LoadingMovies(const []));

  Future<void> fetchMovies() async {
    try {
      emit(LoadingMovies(_movies));
      final movies = await trendingMovies.execute(page: _page);
      _page++;
      emit(MoviesLoaded(_movies..addAll(movies)));
    } on Exception catch (error) {
      emit(LoadingMoviesError(
        _movies,
        error.toString(),
      ));
    }
  }
}
