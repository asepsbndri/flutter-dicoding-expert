import 'package:ditonton/presentation/bloc/top_rated_tv_series_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TopRatedTvSeriesEvent', () {
    test('FetchTopRatedTvSeries props should be empty', () {
      expect( FetchTopRatedTvSeries().props, []);
    });

    test('FetchTopRatedTvSeries equality should work', () {
      expect( FetchTopRatedTvSeries(), equals( FetchTopRatedTvSeries()));
    });
  });
}
