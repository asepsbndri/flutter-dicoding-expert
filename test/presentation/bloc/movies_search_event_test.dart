import 'package:ditonton/presentation/bloc/movies_search_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieSearchEvent', () {
    test('props dari MovieSearchEvent default harus kosong', () {
      // Karena abstract, kita bikin subclass dummy
      const dummyEvent = _DummyMovieSearchEvent();
      expect(dummyEvent.props, isEmpty);
    });
  });

  group('OnMovieQueryChanged', () {
    test('props harus berisi query', () {
      const event = OnMovieQueryChanged('spiderman');
      expect(event.props, ['spiderman']);
    });

    test('dua instance dengan query sama harus equal', () {
      const event1 = OnMovieQueryChanged('batman');
      const event2 = OnMovieQueryChanged('batman');

      expect(event1, equals(event2));
    });

    test('dua instance dengan query beda harus tidak equal', () {
      const event1 = OnMovieQueryChanged('batman');
      const event2 = OnMovieQueryChanged('superman');

      expect(event1, isNot(equals(event2)));
    });
  });
}

class _DummyMovieSearchEvent extends MovieSearchEvent {
  const _DummyMovieSearchEvent();
}
