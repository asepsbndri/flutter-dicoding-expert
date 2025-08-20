import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/popular_movies_state.dart';

void main() {
  group('PopularMoviesState', () {
  final tMovie = Movie(
      adult: false,
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: [14, 28],
      id: 557,
      originalTitle: 'Spider-Man',
      overview: 'After being bitten by a genetically altered spider...',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      releaseDate: '2002-05-01',
      title: 'Spider-Man',
      video: false,
      voteAverage: 7.2,
      voteCount: 13507,
    );

    final tMovieList = [tMovie];

    test('should return initial state with empty values', () {
      final state = PopularMoviesState();
      
      expect(state.state, RequestState.Empty);
      expect(state.movies, []);
      expect(state.message, '');
    });

    test('dua instance dengan data sama harus equal', () {
      final state1 = PopularMoviesState(
        state: RequestState.Loaded,
        movies: tMovieList,
        message: 'Success',
      );
      
      final state2 = PopularMoviesState(
        state: RequestState.Loaded,
        movies: tMovieList,
        message: 'Success',
      );

      expect(state1, equals(state2));
    });

    test('dua instance dengan data beda harus tidak equal', () {
      final state1 = PopularMoviesState(
        state: RequestState.Loaded,
        movies: tMovieList,
        message: 'Success',
      );
      
      final state2 = PopularMoviesState(
        state: RequestState.Loading,
        movies: [],
        message: 'Loading',
      );

      expect(state1, isNot(equals(state2)));
    });

    test('copyWith should return new instance with updated values', () {
      final initialState = PopularMoviesState();
      
      final newState = initialState.copyWith(
        state: RequestState.Loaded,
        movies: tMovieList,
        message: 'Success',
      );

      expect(newState.state, RequestState.Loaded);
      expect(newState.movies, tMovieList);
      expect(newState.message, 'Success');
      expect(newState, isNot(equals(initialState)));
    });

    test('copyWith should retain old values when parameters are null', () {
      final initialState = PopularMoviesState(
        state: RequestState.Loaded,
        movies: tMovieList,
        message: 'Success',
      );
      
      final newState = initialState.copyWith();

      expect(newState, equals(initialState));
    });

    test('props should contain all properties', () {
      final state = PopularMoviesState(
        state: RequestState.Loaded,
        movies: tMovieList,
        message: 'Success',
      );

      expect(state.props, [RequestState.Loaded, tMovieList, 'Success']);
    });
  });
}