import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movie_list_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: '2020-01-01',
    title: 'Title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('MovieListState', () {
    test('default constructor harus punya nilai kosong/Empty', () {
      const state = MovieListState();

      expect(state.nowPlayingMovies, []);
      expect(state.nowPlayingState, RequestState.Empty);
      expect(state.popularMovies, []);
      expect(state.popularMoviesState, RequestState.Empty);
      expect(state.topRatedMovies, []);
      expect(state.topRatedMoviesState, RequestState.Empty);
      expect(state.message, '');
    });

    test('copyWith harus mengubah hanya field yang diberikan', () {
      const initialState = MovieListState();

      final newState = initialState.copyWith(
        nowPlayingMovies: [tMovie],
        nowPlayingState: RequestState.Loaded,
        message: 'success',
      );

      expect(newState.nowPlayingMovies, [tMovie]);
      expect(newState.nowPlayingState, RequestState.Loaded);
      expect(newState.message, 'success');

      // field lain tetap default
      expect(newState.popularMovies, []);
      expect(newState.popularMoviesState, RequestState.Empty);
      expect(newState.topRatedMovies, []);
      expect(newState.topRatedMoviesState, RequestState.Empty);
    });

    test('dua instance dengan data sama harus equal (Equatable)', () {
      const state1 = MovieListState(message: 'same');
      const state2 = MovieListState(message: 'same');

      expect(state1, equals(state2));
    });

    test('dua instance dengan data beda harus tidak equal', () {
      const state1 = MovieListState(message: 'message1');
      const state2 = MovieListState(message: 'message2');

      expect(state1, isNot(equals(state2)));
    });
  });
}
