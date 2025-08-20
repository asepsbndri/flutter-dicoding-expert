import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Dummy lengkap TvSeries
  const testTvSeries = TvSeries(
    id: 1,
    originalName: 'Test Original',
    name: 'Test Series',
    overview: 'Test overview',
    popularity: 100.0,
    backdropPath: '/test_backdrop.jpg',
    posterPath: '/test_poster.jpg',
    firstAirDate: '2023-01-01',
    genreIds: [18],
    voteAverage: 8.5,
    voteCount: 120,
    adult: false,
  );

  // Dummy ringkas dengan constructor watchlist
  const testTvSeriesWatchlist = TvSeries.watchlist(
    id: 2,
    name: 'Watchlist Series',
    overview: 'Overview watchlist',
    posterPath: '/watchlist.jpg',
  );

  group('PopularTvSeriesState', () {
    test('initial() harus punya nilai default yang benar', () {
      final state = PopularTvSeriesState.initial();

      expect(state.state, RequestState.Empty);
      expect(state.tvSeries, []);
      expect(state.message, '');
    });

    test('copyWith harus merubah field yang diberikan', () {
      final state = PopularTvSeriesState.initial();

      final updated = state.copyWith(
        state: RequestState.Loading,
        tvSeries: [testTvSeries],
        message: 'Error message',
      );

      expect(updated.state, RequestState.Loading);
      expect(updated.tvSeries, [testTvSeries]);
      expect(updated.message, 'Error message');
    });

    test('copyWith tanpa argumen harus return state yang sama', () {
      final state = PopularTvSeriesState.initial();

      final updated = state.copyWith();

      expect(updated, state);
    });

    test('equatable bekerja dengan benar', () {
      final state1 = PopularTvSeriesState.initial();
      final state2 = PopularTvSeriesState.initial();

      expect(state1, equals(state2));
    });

    test('copyWith juga bisa dipakai dengan TvSeries.watchlist', () {
      final state = PopularTvSeriesState.initial();

      final updated = state.copyWith(
        state: RequestState.Loaded,
        tvSeries: [testTvSeriesWatchlist],
      );

      expect(updated.state, RequestState.Loaded);
      expect(updated.tvSeries, [testTvSeriesWatchlist]);
    });
  });
}
