import 'package:ditonton/presentation/bloc/watchlist_movies_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WatchlistMovieEvent', () {
    test('FetchWatchlistMovies props should be empty list', () {
      expect( FetchWatchlistMovies().props, []);
    });

    test('FetchWatchlistMovies supports equality', () {
      expect( FetchWatchlistMovies(), equals( FetchWatchlistMovies()));
    });
  });
}
