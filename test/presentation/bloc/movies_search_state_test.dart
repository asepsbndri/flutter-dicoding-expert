import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies_search_state.dart';
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
  final tMovieList = <Movie>[tMovie];

  group('MovieSearchState', () {
    test('MovieSearchEmpty harus props kosong', () {
      expect(MovieSearchEmpty().props, []);
    });

    test('MovieSearchLoading harus props kosong', () {
      expect(MovieSearchLoading().props, []);
    });

    test('MovieSearchError harus punya props [message]', () {
      const state = MovieSearchError('Error message');
      expect(state.props, ['Error message']);
    });

    test('MovieSearchHasData harus punya props [result]', () {
      final state = MovieSearchHasData(tMovieList);
      expect(state.props, [tMovieList]);
    });

    test('dua instance MovieSearchError dengan message sama harus equal', () {
      const state1 = MovieSearchError('error');
      const state2 = MovieSearchError('error');
      expect(state1, equals(state2));
    });

    test('dua instance MovieSearchError dengan message beda harus tidak equal', () {
      const state1 = MovieSearchError('error1');
      const state2 = MovieSearchError('error2');
      expect(state1, isNot(equals(state2)));
    });

    test('dua instance MovieSearchHasData dengan list sama harus equal', () {
      final state1 = MovieSearchHasData(tMovieList);
      final state2 = MovieSearchHasData(tMovieList);
      expect(state1, equals(state2));
    });

    test('dua instance MovieSearchHasData dengan list beda harus tidak equal', () {
      final state1 = MovieSearchHasData(tMovieList);
      final state2 = MovieSearchHasData([]);
      expect(state1, isNot(equals(state2)));
    });
  });
}
