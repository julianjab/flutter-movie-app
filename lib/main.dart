import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/src/data/repositories/api_movie_repository.dart';
import 'package:flutter_movies_app/src/domain/usecases/get_movies.dart';
import 'package:flutter_movies_app/src/presentation/bloc/trending_movies_cubit.dart';
import 'package:flutter_movies_app/src/presentation/pages/trending_movies.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<GetMovies>(
      create: (_) => GetMovies(ApiMovieRepository(http.Client())),
      child: MaterialApp(
        title: 'Tendencias',
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        home: BlocProvider<TrendingMoviesCubit>(
          create: (context) => TrendingMoviesCubit(context.read()),
          child: const TrendingMoviesPage(title: 'Tendencias'),
        ),
      ),
    );
  }
}
