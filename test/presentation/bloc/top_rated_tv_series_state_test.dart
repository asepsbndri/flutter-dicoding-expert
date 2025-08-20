import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeries = TvSeries(
    adult: false,
    id: 1,
    name: 'Test Series',
    overview: 'Overview',
    posterPath: '/path.jpg',
    firstAirDate: '2020-01-01',
    voteAverage: 8.0,
    voteCount: 100,
    genreIds: [1],
    backdropPath: '/backdrop.jpg',
    popularity: 100,
    originalName: 'Original Name',
  );

  group('TopRatedTvSeriesState', () {
    test('supports value equality', () {
      expect(
        const TopRatedTvSeriesState(),
        equals(const TopRatedTvSeriesState()),
      );
    });

    test('props are correct', () {
      const state = TopRatedTvSeriesState();
      expect(state.props, [RequestState.Empty, [], '']);
    });

    test('copyWith returns new object with updated values', () {
      final state = TopRatedTvSeriesState().copyWith(
        state: RequestState.Loaded,
        tvSeries: [tTvSeries],
        message: 'Success',
      );

      expect(state.state, RequestState.Loaded);
      expect(state.tvSeries, [tTvSeries]);
      expect(state.message, 'Success');
    });

    test('copyWith retains old values if null passed', () {
      const state = TopRatedTvSeriesState(
        state: RequestState.Loading,
        tvSeries: [],
        message: 'Loading...',
      );

      final newState = state.copyWith();

      expect(newState.state, RequestState.Loading);
      expect(newState.tvSeries, []);
      expect(newState.message, 'Loading...');
    });
  });
}
