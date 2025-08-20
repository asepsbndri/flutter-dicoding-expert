import 'package:ditonton/presentation/bloc/movie_detail_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieDetailEvent', () {
    const tId = 1;
    const tMovie = 'dummyMovie'; // bisa pakai MovieDetail dummy, tapi string juga cukup utk test equatable

    test('FetchMovieDetailEvent props should contain id', () {
      const event = FetchMovieDetailEvent(tId);

      expect(event.props, [tId]);
      expect(event == const FetchMovieDetailEvent(tId), true);
      expect(event == const FetchMovieDetailEvent(2), false);
    });

    test('AddWatchlistEvent props should contain movie', () {
      const event = AddWatchlistEvent(tMovie);

      expect(event.props, [tMovie]);
      expect(event == const AddWatchlistEvent(tMovie), true);
      expect(event == const AddWatchlistEvent('other'), false);
    });

    test('RemoveWatchlistEvent props should contain movie', () {
      const event = RemoveWatchlistEvent(tMovie);

      expect(event.props, [tMovie]);
      expect(event == const RemoveWatchlistEvent(tMovie), true);
      expect(event == const RemoveWatchlistEvent('other'), false);
    });

    test('LoadWatchlistStatusEvent props should contain id', () {
      const event = LoadWatchlistStatusEvent(tId);

      expect(event.props, [tId]);
      expect(event == const LoadWatchlistStatusEvent(tId), true);
      expect(event == const LoadWatchlistStatusEvent(2), false);
    });
  });
}
