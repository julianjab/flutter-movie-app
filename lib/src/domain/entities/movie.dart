import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String backdropImage;
  final String posterImage;
  final DateTime? releaseDate;
  final String? overview;

  const Movie({
    required this.id,
    required this.title,
    required this.backdropImage,
    required this.posterImage,
    this.releaseDate,
    this.overview,
  });

  @override
  List<dynamic> get props =>
      [id, title, backdropImage, posterImage, releaseDate, overview];
}
