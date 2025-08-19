import 'package:equatable/equatable.dart';
import 'genre.dart';

class TvSeriesDetail extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final String firstAirDate;
  final int numberOfSeasons;
  final int numberOfEpisodes;

  const TvSeriesDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.firstAirDate,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        voteCount,
        genres,
        firstAirDate,
        numberOfSeasons,
        numberOfEpisodes,
      ];
}
