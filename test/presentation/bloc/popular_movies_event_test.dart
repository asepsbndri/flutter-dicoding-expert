import 'package:ditonton/presentation/bloc/popular_movies_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PopularMoviesEvent', () {
    test('props dari FetchPopularMovies harus kosong', () {
      expect( FetchPopularMovies().props, []);
    });

    test('dua instance FetchPopularMovies harus sama (equatable works)', () {
      expect( FetchPopularMovies(), equals( FetchPopularMovies()));
    });

    test('instance FetchPopularMovies tidak null', () {
      expect( FetchPopularMovies(), isNotNull);
    });
  });
}
