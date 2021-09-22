import 'package:flutter_movies_app/src/domain/entities/movie.dart';
import 'package:flutter_movies_app/src/domain/exceptions/loading_movies_exception.dart';
import 'package:flutter_movies_app/src/domain/usecases/get_movies.dart';
import 'package:flutter_movies_app/src/presentation/cubit/movies_state.dart';
import 'package:flutter_movies_app/src/presentation/cubit/trending_movies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'trending_movies_cubit_test.mocks.dart';

final movies = [
  Movie(
    id: 1,
    title: 'First movie',
    releaseDate: DateTime(2020),
    posterImage: 'posterImage',
    backdropImage: 'backdropImage',
  ),
  Movie(
    id: 2,
    title: 'Second movie',
    releaseDate: DateTime(2020),
    posterImage: 'posterImage',
    backdropImage: 'backdropImage',
  ),
];

@GenerateMocks([GetMovies])
void main() {
  late GetMovies getMovies;
  late TrendingMoviesCubit trendingMoviesCubit;

  setUp(() async {
    getMovies = MockGetMovies();
    trendingMoviesCubit = TrendingMoviesCubit(getMovies);
  });

  group('TrendingMoviesCubit', () {
    test('should initilize with a [LoadingMovies] state', () {
      expect(trendingMoviesCubit.state.runtimeType, LoadingMovies);
    });

    test(
      'should emit a [LoadingMovies] state when fetch movies has been called',
      () async {
        when(getMovies.execute(
                page: anyNamed('page'), language: anyNamed('language')))
            .thenAnswer((_) async => movies);

        trendingMoviesCubit.fetchMovies();

        expect(trendingMoviesCubit.state, const LoadingMovies([]));
        expect(trendingMoviesCubit.state.movies.isEmpty, true);
      },
    );

    test(
      'should emit a [MoviesLoaded] state with movies when get movies returns movies',
      () async {
        when(getMovies.execute(
                page: anyNamed('page'), language: anyNamed('language')))
            .thenAnswer((_) async => movies);

        await trendingMoviesCubit.fetchMovies();

        await expectLater(trendingMoviesCubit.state, MoviesLoaded(movies));
      },
    );

    test(
      'should emit a [LoadingMoviesError] state when get movies throws an error',
      () async {
        when(getMovies.execute(
                page: anyNamed('page'), language: anyNamed('language')))
            .thenThrow(LoadingMoviesException('Unknown error'));

        await trendingMoviesCubit.fetchMovies();

        await expectLater(trendingMoviesCubit.state,
            const LoadingMoviesError([], 'Unknown error'));
      },
    );

    test(
      'should emit a [LoadingMovies] state with movies when fetch movies was called a second time',
      () async {
        when(getMovies.execute(
                page: anyNamed('page'), language: anyNamed('language')))
            .thenAnswer((_) async => movies);

        await trendingMoviesCubit.fetchMovies();
        trendingMoviesCubit.fetchMovies();

        expect(trendingMoviesCubit.state, LoadingMovies(movies));
      },
    );

    test(
      'should emit a [LoadingMoviesError] state with movies when fetch movies is called a second time',
      () async {
        when(getMovies.execute(page: 1, language: anyNamed('language')))
            .thenAnswer((_) async => movies);
        when(getMovies.execute(page: 2, language: anyNamed('language')))
            .thenThrow(LoadingMoviesException('Unknown error'));

        await trendingMoviesCubit.fetchMovies();
        trendingMoviesCubit.fetchMovies();

        expect(trendingMoviesCubit.state,
            LoadingMoviesError(movies, 'Unknown error'));
      },
    );
  });
}
