import 'package:ditonton/presentation/bloc/on_airing_tv_series_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnAiringTvSeriesEvent', () {
    test('FetchOnAiringTvSeries props harus kosong', () {
      expect( FetchOnAiringTvSeries().props, []);
    });

    test('dua instance FetchOnAiringTvSeries harus equal', () {
      expect( FetchOnAiringTvSeries(), equals( FetchOnAiringTvSeries()));
    });

    test('instance FetchOnAiringTvSeries tidak null', () {
      expect( FetchOnAiringTvSeries(), isNotNull);
    });
  });
}
