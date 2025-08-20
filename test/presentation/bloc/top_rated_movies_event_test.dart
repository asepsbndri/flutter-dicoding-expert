import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_event.dart';

void main() {
  test('supports value comparisons', () {
    expect(FetchTopRatedMovies(), FetchTopRatedMovies());
  });
}
