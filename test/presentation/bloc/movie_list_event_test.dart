import 'package:ditonton/presentation/bloc/movie_list_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieListEvent', () {
    test('FetchNowPlayingMovies props harus kosong', () {
      expect( FetchNowPlayingMovies().props, []);
    });

    test('FetchPopularMovies props harus kosong', () {
      expect( FetchPopularMovies().props, []);
    });

    test('FetchTopRatedMovies props harus kosong', () {
      expect( FetchTopRatedMovies().props, []);
    });

    test('dua instance FetchNowPlayingMovies harus equal', () {
      expect( FetchNowPlayingMovies(), equals( FetchNowPlayingMovies()));
    });

    test('dua instance FetchPopularMovies harus equal', () {
      expect( FetchPopularMovies(), equals( FetchPopularMovies()));
    });

    test('dua instance FetchTopRatedMovies harus equal', () {
      expect( FetchTopRatedMovies(), equals( FetchTopRatedMovies()));
    });

    test('FetchNowPlayingMovies tidak sama dengan FetchPopularMovies', () {
      expect( FetchNowPlayingMovies(), isNot( FetchPopularMovies()));
    });
  });
}
