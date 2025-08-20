import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/on_airing_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    firstAirDate: '2020-01-01',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Test Series',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    voteAverage: 8.5,
    voteCount: 100,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('OnAiringTvSeriesState', () {
    test('default constructor harus punya nilai awal yang benar', () {
      const state = OnAiringTvSeriesState();

      expect(state.state, RequestState.Empty);
      expect(state.tvSeries, []);
      expect(state.message, '');
    });

    test('copyWith hanya mengubah field yang diberikan', () {
      const initialState = OnAiringTvSeriesState();

      final newState = initialState.copyWith(
        state: RequestState.Loaded,
        tvSeries: tTvSeriesList,
        message: 'success',
      );

      expect(newState.state, RequestState.Loaded);
      expect(newState.tvSeries, tTvSeriesList);
      expect(newState.message, 'success');
    });

    test('dua instance dengan data sama harus equal', () {
      const state1 = OnAiringTvSeriesState(message: 'same');
      const state2 = OnAiringTvSeriesState(message: 'same');

      expect(state1, equals(state2));
    });

    test('dua instance dengan data beda harus tidak equal', () {
      const state1 = OnAiringTvSeriesState(message: 'message1');
      const state2 = OnAiringTvSeriesState(message: 'message2');

      expect(state1, isNot(equals(state2)));
    });
  });
}
