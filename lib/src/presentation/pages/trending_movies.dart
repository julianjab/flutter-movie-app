import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/src/domain/entities/movie.dart';
import 'package:flutter_movies_app/src/presentation/cubit/movies_state.dart';
import 'package:flutter_movies_app/src/presentation/cubit/trending_movies_cubit.dart';
import 'package:flutter_movies_app/src/presentation/widgets/movie.dart';
import 'package:intl/date_symbol_data_local.dart';

class TrendingMoviesPage extends StatefulWidget {
  const TrendingMoviesPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _TrendingMoviesPage();
  }
}

class _TrendingMoviesPage extends State<TrendingMoviesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_US');
    context.read<TrendingMoviesCubit>().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildContent(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: false,
    );
  }

  Widget _buildContent(
    BuildContext context,
  ) {
    return BlocBuilder<TrendingMoviesCubit, MoviesState>(
        builder: (context, state) {
      if (state is LoadingMovies && state.movies.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is LoadingMoviesError && state.movies.isEmpty) {
        return _buildErrorMessage(context, state.message);
      }

      if (state is LoadingMoviesError) {
        final themeData = Theme.of(context);
        final snackBar = SnackBar(
          content: Text(state.message),
          backgroundColor: themeData.errorColor,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      return _buildMoviesList(state.movies);
    });
  }

  Widget _buildMoviesList(List<Movie> movies) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScrollNotification,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          final movie = movies[index];
          return MovieWidget(
            key: Key(movie.id.toString()),
            title: movie.title,
            backdropImage: movie.backdropImage,
            posterImage: movie.posterImage,
            releaseDate: movie.releaseDate,
            overView: movie.overview,
            onClick: () {},
          );
        },
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context, String message) {
    return Center(child: Text(message));
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      context.read<TrendingMoviesCubit>().fetchMovies();
    }

    return false;
  }
}
