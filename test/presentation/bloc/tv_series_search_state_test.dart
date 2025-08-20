import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeries = TvSeries(
    id: 1,
    originalName: 'Breaking Bad',
    name: 'Breaking Bad',
    overview: 'A high school chemistry teacher turned meth producer.',
    popularity: 99.9,
    backdropPath: '/backdrop.jpg',
    posterPath: '/poster.jpg',
    firstAirDate: '2008-01-20',
    genreIds: [18, 80],
    voteAverage: 9.0,
    voteCount: 1000,
    adult: false,
  );

  const tTvSeriesWatchlist = TvSeries.watchlist(
    id: 1,
    overview: 'A high school chemistry teacher turned meth producer.',
    posterPath: '/poster.jpg',
    name: 'Breaking Bad',
  );

  test('should support value comparison', () {
    const tvSeries1 = TvSeries(
      id: 1,
      originalName: 'Breaking Bad',
      name: 'Breaking Bad',
      overview: 'A high school chemistry teacher turned meth producer.',
      popularity: 99.9,
      backdropPath: '/backdrop.jpg',
      posterPath: '/poster.jpg',
      firstAirDate: '2008-01-20',
      genreIds: [18, 80],
      voteAverage: 9.0,
      voteCount: 1000,
      adult: false,
    );

    expect(tTvSeries, tvSeries1);
  });

  test('props should contain correct values', () {
    expect(
      tTvSeries.props,
      [
        1,
        'Breaking Bad',
        'Breaking Bad',
        'A high school chemistry teacher turned meth producer.',
        99.9,
        '/backdrop.jpg',
        '/poster.jpg',
        '2008-01-20',
        [18, 80],
        9.0,
        1000,
        false,
      ],
    );
  });

  test('watchlist constructor should assign correct values', () {
    expect(tTvSeriesWatchlist.id, 1);
    expect(tTvSeriesWatchlist.name, 'Breaking Bad');
    expect(tTvSeriesWatchlist.overview,
        'A high school chemistry teacher turned meth producer.');
    expect(tTvSeriesWatchlist.posterPath, '/poster.jpg');

    // nilai default dari watchlist constructor
    expect(tTvSeriesWatchlist.originalName, '');
    expect(tTvSeriesWatchlist.popularity, 0);
    expect(tTvSeriesWatchlist.backdropPath, null);
    expect(tTvSeriesWatchlist.firstAirDate, null);
    expect(tTvSeriesWatchlist.genreIds, []);
    expect(tTvSeriesWatchlist.voteAverage, 0);
    expect(tTvSeriesWatchlist.voteCount, 0);
    expect(tTvSeriesWatchlist.adult, false);
  });
}
