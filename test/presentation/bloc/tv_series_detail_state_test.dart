import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSeriesDetailState', () {
    test('props harus mengandung semua field', () {
      const state = TvSeriesDetailState();

      expect(state.props, [
        null, // tvSeries
        RequestState.Empty, // tvSeriesState
        const <TvSeries>[], // recommendations
        RequestState.Empty, // recommendationState
        '', // message
        false, // isAddedToWatchlist
        '', // watchlistMessage
      ]);
    });

    test('copyWith harus mereturn state baru dengan value yang diupdate', () {
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

      final tRecommendations = [
        TvSeries(
          adult: false,
           genreIds: const [1, 2],
          id: 1,
          name: 'Rec Series',
          overview: 'Overview',
          posterPath: '/poster.jpg',
          firstAirDate: '2021-01-01',
          voteAverage: 7.0,
          voteCount: 50,
          popularity: 80.0,
          backdropPath: '/backdrop.jpg',
          originalName: 'Rec Original',
        ),
      ];

      const state = TvSeriesDetailState();

      final updated = state.copyWith(
        tvSeries: tTvSeriesDetail,
        tvSeriesState: RequestState.Loaded,
        recommendations: tRecommendations,
        recommendationState: RequestState.Loaded,
        message: 'Success',
        isAddedToWatchlist: true,
        watchlistMessage: 'Added',
      );

      expect(updated.tvSeries, tTvSeriesDetail);
      expect(updated.tvSeriesState, RequestState.Loaded);
      expect(updated.recommendations, tRecommendations);
      expect(updated.recommendationState, RequestState.Loaded);
      expect(updated.message, 'Success');
      expect(updated.isAddedToWatchlist, true);
      expect(updated.watchlistMessage, 'Added');
    });

    test('copyWith tanpa argumen harus return state yang sama', () {
      const state = TvSeriesDetailState(message: 'Initial');
      final updated = state.copyWith();

      expect(updated, state);
    });

    test('equality harus benar', () {
      const state1 = TvSeriesDetailState(message: 'Hello');
      const state2 = TvSeriesDetailState(message: 'Hello');

      expect(state1, state2);
    });
  });
}
