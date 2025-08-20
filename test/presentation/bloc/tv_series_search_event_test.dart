import 'package:ditonton/presentation/bloc/tv_series_search_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvSeriesSearchEvent', () {
    test('props dari base class harus kosong', () {
      const event = _DummyTvSeriesSearchEvent();
      expect(event.props, isEmpty);
    });
  });

  group('OnTvSeriesQueryChanged Event', () {
    test('supports value equality', () {
      expect(
        const OnTvSeriesQueryChanged('query'),
        equals(const OnTvSeriesQueryChanged('query')),
      );
    });

    test('props should contain query', () {
      const event = OnTvSeriesQueryChanged('Breaking Bad');
      expect(event.props, ['Breaking Bad']);
    });

    test('different queries should not be equal', () {
      const event1 = OnTvSeriesQueryChanged('Breaking Bad');
      const event2 = OnTvSeriesQueryChanged('Better Call Saul');

      expect(event1 == event2, false);
    });

    test('toString should include query value', () {
      const event = OnTvSeriesQueryChanged('Breaking Bad');
      expect(event.toString(), contains('Breaking Bad'));
    });
  });
}

class _DummyTvSeriesSearchEvent extends TvSeriesSearchEvent {
  const _DummyTvSeriesSearchEvent();
}
