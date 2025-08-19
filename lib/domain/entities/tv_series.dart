import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  final int id;
  final String originalName;
  final String name;
  final String overview;
  final double popularity;
  final String? backdropPath;
  final String? posterPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final double voteAverage;
  final int voteCount;
  final bool adult;

  const TvSeries({
    required this.id,
    required this.originalName,
    required this.name,
    required this.overview,
    required this.popularity,
    this.backdropPath,
    this.posterPath,
    this.firstAirDate,
    required this.genreIds,
    required this.voteAverage,
    required this.voteCount,
    required this.adult,
  });

  const TvSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  })  : originalName = '',
        popularity = 0,
        backdropPath = null,
        firstAirDate = null,
        genreIds = const [],
        voteAverage = 0,
        voteCount = 0,
        adult = false;

  @override
  List<Object?> get props => [
        id,
        originalName,
        name,
        overview,
        popularity,
        backdropPath,
        posterPath,
        firstAirDate,
        genreIds,
        voteAverage,
        voteCount,
        adult,
      ];
}
