import 'package:ditonton/presentation/bloc/watchlist_tv_series_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WatchlistTvEvent', () {
    test('props dari FetchWatchlistTvSeries harus kosong', () {
      expect( FetchWatchlistTvSeries().props, []);
    });

    test('dua instance FetchWatchlistTvSeries harus equal', () {
      expect( FetchWatchlistTvSeries(),  FetchWatchlistTvSeries());
    });

    test('FetchWatchlistTvSeries harus turunan dari WatchlistTvEvent', () {
      expect( FetchWatchlistTvSeries(), isA<WatchlistTvEvent>());
    });
  });
}
