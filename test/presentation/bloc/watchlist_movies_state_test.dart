import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WatchlistMovieState', () {
    test('supports value equality', () {
      expect(const WatchlistMovieState(), equals(const WatchlistMovieState()));
    });

    test('props should contain correct values', () {
      const state = WatchlistMovieState();
      expect(state.props, [[], RequestState.Empty, '']);
    });

    test('copyWith should update fields', () {
      final movie = Movie.watchlist(
        id: 1,
        overview: 'overview',
        posterPath: '/path.jpg',
        title: 'title',
      );

      const state = WatchlistMovieState();

      final updated = state.copyWith(
        watchlistMovies: [movie],
        watchlistState: RequestState.Loaded,
        message: 'Success',
      );

      expect(updated.watchlistMovies, [movie]);
      expect(updated.watchlistState, RequestState.Loaded);
      expect(updated.message, 'Success');
    });

    test('copyWith should keep old values if no new value is provided', () {
      final movie = Movie.watchlist(
        id: 1,
        overview: 'overview',
        posterPath: '/path.jpg',
        title: 'title',
      );

      final state = WatchlistMovieState(
        watchlistMovies: [movie],
        watchlistState: RequestState.Loaded,
        message: 'Success',
      );

      final updated = state.copyWith();

      expect(updated.watchlistMovies, [movie]);
      expect(updated.watchlistState, RequestState.Loaded);
      expect(updated.message, 'Success');
    });
  });
}
