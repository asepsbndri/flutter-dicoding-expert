import 'package:ditonton/presentation/bloc/popular_tv_series_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PopularTvSeriesEvent', () {
    test('props dari FetchPopularTvSeries harus kosong', () {
      expect( FetchPopularTvSeries().props, []);
    });

    test('dua instance FetchPopularTvSeries harus equal', () {
      expect( FetchPopularTvSeries(),  FetchPopularTvSeries());
    });

    test('FetchPopularTvSeries harus turunan PopularTvSeriesEvent', () {
      expect( FetchPopularTvSeries(), isA<PopularTvSeriesEvent>());
    });
  });
}
