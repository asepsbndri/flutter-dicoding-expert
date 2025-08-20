import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSeriesDetailEvent', () {
    test('FetchTvSeriesDetailEvent props harus mengandung id', () {
      const event = FetchTvSeriesDetailEvent(1);

      expect(event.props, [1]);
    });

    test('AddWatchlistTvSeriesEvent props harus mengandung tvSeries', () {
      final tTvSeriesDetail = TvSeriesDetail(
        id: 1,
        name: 'Test Series',
        overview: 'Overview',
        posterPath: '/path.jpg',
        firstAirDate: '2020-01-01',
        voteAverage: 8.0,
        voteCount: 100,
        genres: [],
        numberOfEpisodes: 10,
        numberOfSeasons: 1,
        backdropPath: '/backdrop.jpg',
      );

      final event = AddWatchlistTvSeriesEvent(tTvSeriesDetail);

      expect(event.props, [tTvSeriesDetail]);
    });

    test('RemoveWatchlistTvSeriesEvent props harus mengandung tvSeries', () {
      final tTvSeriesDetail = TvSeriesDetail(
        id: 2,
        name: 'Another Series',
        overview: 'Another Overview',
        posterPath: '/poster2.jpg',
        firstAirDate: '2021-01-01',
        voteAverage: 7.5,
        voteCount: 50,
        genres: [],
        numberOfEpisodes: 8,
        numberOfSeasons: 1,
        backdropPath: '/backdrop2.jpg',
      );

      final event = RemoveWatchlistTvSeriesEvent(tTvSeriesDetail);

      expect(event.props, [tTvSeriesDetail]);
    });

    test('LoadWatchlistStatusTvSeriesEvent props harus mengandung id', () {
      const event = LoadWatchlistStatusTvSeriesEvent(99);

      expect(event.props, [99]);
    });

    test('Event equality harus bekerja dengan benar', () {
      expect(const FetchTvSeriesDetailEvent(1), const FetchTvSeriesDetailEvent(1));
      expect(const LoadWatchlistStatusTvSeriesEvent(2),
          const LoadWatchlistStatusTvSeriesEvent(2));

      final tTvSeriesDetail = TvSeriesDetail(
        id: 3,
        name: 'Equal Series',
        overview: 'Equal Overview',
        posterPath: '/poster3.jpg',
        firstAirDate: '2019-01-01',
        voteAverage: 9.0,
        voteCount: 150,
        genres: [],
        numberOfEpisodes: 12,
        numberOfSeasons: 2,
        backdropPath: '/backdrop3.jpg',
      );

      expect(
        AddWatchlistTvSeriesEvent(tTvSeriesDetail),
        AddWatchlistTvSeriesEvent(tTvSeriesDetail),
      );
      expect(
        RemoveWatchlistTvSeriesEvent(tTvSeriesDetail),
        RemoveWatchlistTvSeriesEvent(tTvSeriesDetail),
      );
    });
  });
}
