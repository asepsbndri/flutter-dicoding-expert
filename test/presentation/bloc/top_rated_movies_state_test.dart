import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovie = Movie(
    id: 1,
    title: 'Test Movie',
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: '2020-01-01',
    voteAverage: 8.0,
    voteCount: 100,
    genreIds: [1, 2],
    backdropPath: '/backdrop.jpg',
    popularity: 100.0,
    adult: false,
    video: false,
    originalTitle: 'Original Title',
  );

  group('TopRatedMoviesState', () {
    test('supports value equality', () {
      expect(
        const TopRatedMoviesState(),
        const TopRatedMoviesState(),
      );
    });

    test('default values are correct', () {
      const state = TopRatedMoviesState();
      expect(state.state, RequestState.Empty);
      expect(state.movies, []);
      expect(state.message, '');
    });

    test('copyWith updates values correctly', () {
      const initial = TopRatedMoviesState();
      final updated = initial.copyWith(
        state: RequestState.Loaded,
        movies: [tMovie],
        message: 'Success',
      );

      expect(updated.state, RequestState.Loaded);
      expect(updated.movies, [tMovie]);
      expect(updated.message, 'Success');
    });

    test('copyWith keeps old values when not provided', () {
      const initial = TopRatedMoviesState(
        state: RequestState.Loading,
        movies: [],
        message: 'Loading',
      );
      final updated = initial.copyWith();

      expect(updated.state, RequestState.Loading);
      expect(updated.movies, []);
      expect(updated.message, 'Loading');
    });
  });
}
