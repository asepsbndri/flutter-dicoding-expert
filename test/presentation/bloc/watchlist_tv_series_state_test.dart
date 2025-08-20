import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_state.dart';

void main() {
  group('WatchlistTvState', () {
    const tTvSeries = TvSeries(
      adult: false,
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: [16, 10765, 10759],
      id: 94605,
      originalName: 'Arcane',
      overview: 'Amid the stark discord of twin cities Piltover and Zaun...',
      popularity: 1238.585,
      posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
      firstAirDate: '2021-11-06',
      name: 'Arcane',
      voteAverage: 8.7,
      voteCount: 2875,
    );

    const tTvSeriesList = [tTvSeries];

    test('should return initial state with empty values', () {
      const state = WatchlistTvState();
      
      expect(state.watchlistState, RequestState.Empty);
      expect(state.watchlistTvSeries, []);
      expect(state.message, '');
    });

    test('dua instance dengan data sama harus equal', () {
      const state1 = WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: tTvSeriesList,
        message: 'Success',
      );
      
      const state2 = WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: tTvSeriesList,
        message: 'Success',
      );

      expect(state1, equals(state2));
    });

    test('dua instance dengan data beda harus tidak equal', () {
      const state1 = WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: tTvSeriesList,
        message: 'Success',
      );
      
      const state2 = WatchlistTvState(
        watchlistState: RequestState.Loading,
        watchlistTvSeries: [],
        message: 'Loading',
      );

      expect(state1, isNot(equals(state2)));
    });

    test('copyWith should return new instance with updated values', () {
      const initialState = WatchlistTvState();
      
      final newState = initialState.copyWith(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: tTvSeriesList,
        message: 'Success',
      );

      expect(newState.watchlistState, RequestState.Loaded);
      expect(newState.watchlistTvSeries, tTvSeriesList);
      expect(newState.message, 'Success');
      expect(newState, isNot(equals(initialState)));
    });

    test('copyWith should retain old values when parameters are null', () {
      const initialState = WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: tTvSeriesList,
        message: 'Success',
      );
      
      final newState = initialState.copyWith();

      expect(newState, equals(initialState));
    });

    test('props should contain all properties', () {
      const state = WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: tTvSeriesList,
        message: 'Success',
      );

      expect(state.props, [RequestState.Loaded, tTvSeriesList, 'Success']);
    });
  });
}