import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSeriesListState', () {
    test('should support value equality', () {
      expect(
        const TvSeriesListState(),
        equals(const TvSeriesListState()),
      );
    });

    test('should have correct props', () {
      const state = TvSeriesListState(
        onAiringTvSeries: [],
        onAiringState: RequestState.Empty,
        popularTvSeries: [],
        popularTvSeriesState: RequestState.Empty,
        topRatedTvSeries: [],
        topRatedTvSeriesState: RequestState.Empty,
        message: '',
      );

      expect(state.props, [
        state.onAiringTvSeries,
        state.onAiringState,
        state.popularTvSeries,
        state.popularTvSeriesState,
        state.topRatedTvSeries,
        state.topRatedTvSeriesState,
        state.message,
      ]);
    });

    test('copyWith should update specified fields', () {
      final tvSeries = TvSeries(
        adult: false,
        id: 1,
        name: 'Test TV',
        overview: 'Overview',
        posterPath: '/test.jpg',
        backdropPath: '/backdrop.jpg',
        voteAverage: 8.5,
        voteCount: 100,
        firstAirDate: '2022-01-01',
        genreIds: const [1, 2],
   
        originalName: 'Original Test TV',
        popularity: 99.9,
      );

      const initialState = TvSeriesListState();

      final updatedState = initialState.copyWith(
        onAiringTvSeries: [tvSeries],
        onAiringState: RequestState.Loaded,
        popularTvSeriesState: RequestState.Error,
        message: 'Error message',
      );

      expect(updatedState.onAiringTvSeries, [tvSeries]);
      expect(updatedState.onAiringState, RequestState.Loaded);
      expect(updatedState.popularTvSeriesState, RequestState.Error);
      expect(updatedState.message, 'Error message');
    });

    test('copyWith without arguments should return same object', () {
      const initialState = TvSeriesListState();
      final copiedState = initialState.copyWith();

      expect(copiedState, equals(initialState));
    });
  });
}
