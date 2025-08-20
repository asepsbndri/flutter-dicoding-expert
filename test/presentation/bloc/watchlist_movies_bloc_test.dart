import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movies_bloc_test.mocks.dart';


@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

   final tMovie = Movie(
    adult: false,
    backdropPath: "/backdrop.jpg",
    genreIds: [1, 2],
    id: 1,
    originalTitle: "Original Title",
    overview: "Overview",
    popularity: 9.0,
    posterPath: "/poster.jpg",
    releaseDate: "2020-01-01",
    title: "Title",
    video: false,
    voteAverage: 8.5,
    voteCount: 100,
  );

  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(watchlistMovieBloc.state, const WatchlistMovieState());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      const WatchlistMovieState(
        watchlistState: RequestState.Loading,
      ),
      WatchlistMovieState(
        watchlistState: RequestState.Loaded,
        watchlistMovies: tMovieList,
      ),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'should emit [Loading, Error] when getting data fails',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovies()),
    expect: () => [
      const WatchlistMovieState(
        watchlistState: RequestState.Loading,
      ),
      const WatchlistMovieState(
        watchlistState: RequestState.Error,
        message: "Can't get data",
      ),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
