import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieDetailState', () {
    test('should support value equality', () {
      const state1 = MovieDetailState();
      const state2 = MovieDetailState();

      expect(state1, equals(state2));
    });

    test('default values should be correct', () {
      const state = MovieDetailState();

      expect(state.movieState, RequestState.Empty);
      expect(state.movie, null);
      expect(state.recommendations, isEmpty);
      expect(state.recommendationState, RequestState.Empty);
      expect(state.message, '');
      expect(state.isAddedToWatchlist, false);
      expect(state.watchlistMessage, '');
    });

    test('copyWith should override values correctly', () {
      const movieDetail = MovieDetail(
        adult: false,
        backdropPath: '/backdrop.jpg',
        originalTitle: 'Original Title',
        id: 1,
        title: 'Test Movie',
        overview: 'Overview',
        posterPath: '/path.jpg',
        voteAverage: 8.0,
        voteCount: 100,
        runtime: 120,
        releaseDate: '2024-01-01',
        genres: [],
      );
      final movieList = [
         Movie( 
          originalTitle: 'Original Title',
          voteAverage: 8.0,
          voteCount: 100,
          releaseDate: '2024-01-01',
          popularity: 50.0,
          video: false,
          genreIds: [1, 2],
          backdropPath: '/backdrop.jpg',
          adult: false,
          id: 1,
          overview: 'Overview',
          posterPath: '/path.jpg',
          title: 'Test Movie',
        ),
      ];

      const state = MovieDetailState();

      final updated = state.copyWith(
        movieState: RequestState.Loaded,
        movie: movieDetail,
        recommendations: movieList,
        recommendationState: RequestState.Loaded,
        message: 'error',
        isAddedToWatchlist: true,
        watchlistMessage: 'Added',
      );

      expect(updated.movieState, RequestState.Loaded);
      expect(updated.movie, movieDetail);
      expect(updated.recommendations, movieList);
      expect(updated.recommendationState, RequestState.Loaded);
      expect(updated.message, 'error');
      expect(updated.isAddedToWatchlist, true);
      expect(updated.watchlistMessage, 'Added');
    });

    test('copyWith should keep old values if not overridden', () {
       const state = MovieDetailState(
        movieState: RequestState.Loading,
        message: 'initial',
        isAddedToWatchlist: true,
      );

      final updated = state.copyWith();

      expect(updated.movieState, state.movieState);
      expect(updated.message, state.message);
      expect(updated.isAddedToWatchlist, state.isAddedToWatchlist);
    });
  });
}
