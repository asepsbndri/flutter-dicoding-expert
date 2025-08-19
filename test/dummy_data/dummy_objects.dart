import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};


final testTvSeries = TvSeries(
  adult: false,
  backdropPath: '/path/to/backdrop.jpg',
  genreIds: [18, 80],
  id: 1,
  originalName: 'Original Name',
  name: 'Tv Series Name',
  overview: 'This is a test overview for the TV series.',
  popularity: 100.0,
  posterPath: '/path/to/poster.jpg',
  firstAirDate: '2023-01-01',
  voteAverage: 8.5,
  voteCount: 1000,
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  id: 1,
  name: 'Squid Game',
  overview: 'Hundreds of cash-strapped players...',
  posterPath: 'posterPath',
  backdropPath: 'backdropPath',
  voteAverage: 8.5,
  voteCount: 5000,
  genres: [Genre(id: 1, name: 'Drama')],
  firstAirDate: '2021-09-17',
  numberOfSeasons: 1,
  numberOfEpisodes: 9,
);


final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'Squid Game',
  posterPath: 'posterPath',
  overview: 'Hundreds of cash-strapped players...',
);

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  title: 'Squid Game',
  posterPath: 'posterPath',
  overview: 'Hundreds of cash-strapped players...',
);

final testTvSeriesMap = {
  'id': 1,
  'title': 'Squid Game',
  'posterPath': 'posterPath',
  'overview': 'Hundreds of cash-strapped players...',
  'type': 'tv',
};