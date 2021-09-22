import 'package:flutter_movies_app/src/domain/entities/movie.dart';
import 'package:flutter_movies_app/src/domain/repositories/movie_repository.dart';
import 'package:flutter_movies_app/src/domain/usecases/get_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'get_movies_test.mocks.dart';

final List<Movie> pageOne = [
  Movie(
    id: 1,
    title: 'Jurasic Hunt',
    releaseDate: DateTime(2021, 9, 1),
    backdropImage: 'test.jpg',
    posterImage: 'test.jpg',
  ),
  Movie(
    id: 2,
    title: 'Matrix',
    releaseDate: DateTime(2020, 1, 1),
    backdropImage: 'test.jpg',
    posterImage: 'test.jpg',
  )
];

final List<Movie> pageTwo = [
  Movie(
    id: 3,
    title: 'Los dioses estan locos',
    backdropImage: 'test.jpg',
    releaseDate: DateTime(2020),
    posterImage: 'test.jpg',
  )
];

@GenerateMocks([MovieRepository])
void main() {
  late GetMovies usecase;
  late MovieRepository movieRepository;

  setUp(() {
    movieRepository = MockMovieRepository();
    usecase = GetMovies(movieRepository);
  });

  group('GetMoviesUseCase', () {
    test("should call the repository when is executed", () async {
      //arrange
      when(movieRepository.getTrending()).thenAnswer((_) async => []);

      // act
      await usecase.execute();

      //assert
      verify(movieRepository.getTrending()).called(1);
    });

    test("should return the movies on first page when is executed without page",
        () async {
      //arrange
      when(movieRepository.getTrending()).thenAnswer((_) async => pageOne);

      //act
      final response = await usecase.execute();

      //assert
      expect(response, pageOne);
      verify(movieRepository.getTrending()).called(1);
    });

    test("should return the movies of page number when is executed with page",
        () async {
      //arrange
      when(movieRepository.getTrending(page: 1))
          .thenAnswer((_) async => pageOne);
      when(movieRepository.getTrending(page: 2))
          .thenAnswer((_) async => pageTwo);

      //act
      final response = await usecase.execute(page: 2);

      //assert
      expect(response, pageTwo);
    });
  });
}
