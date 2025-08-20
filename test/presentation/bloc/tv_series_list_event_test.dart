import 'package:ditonton/presentation/bloc/tv_series_list_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSeriesListEvent', () {
    test('FetchOnAiringTvSeries props harus kosong', () {
      expect( FetchOnAiringTvSeries().props, []);
    });

    test('FetchPopularTvSeries props harus kosong', () {
      expect( FetchPopularTvSeries().props, []);
    });

    test('FetchTopRatedTvSeries props harus kosong', () {
      expect( FetchTopRatedTvSeries().props, []);
    });

    test('FetchOnAiringTvSeries equality', () {
      expect( FetchOnAiringTvSeries(), equals( FetchOnAiringTvSeries()));
    });

    test('FetchPopularTvSeries equality', () {
      expect( FetchPopularTvSeries(), equals( FetchPopularTvSeries()));
    });

    test('FetchTopRatedTvSeries equality', () {
      expect( FetchTopRatedTvSeries(), equals( FetchTopRatedTvSeries()));
    });
  });
}
