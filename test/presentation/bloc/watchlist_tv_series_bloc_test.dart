import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_series_bloc_test.mocks.dart';


@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvBloc bloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    bloc = WatchlistTvBloc(mockGetWatchlistTvSeries);
  });

  const tTvSeries = TvSeries(
    id: 1,
    originalName: 'Original Name',
    name: 'Name',
    overview: 'Overview',
    popularity: 1.0,
    backdropPath: 'backdropPath',
    posterPath: 'posterPath',
    firstAirDate: '2020-01-01',
    genreIds: [1, 2],
    voteAverage: 8.5,
    voteCount: 100,
    adult: false,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('initial state should be empty', () {
    expect(bloc.state, const WatchlistTvState());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      const WatchlistTvState(watchlistState: RequestState.Loading),
      WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: tTvSeriesList,
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'emits [Loading, Error] when get data fails',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTvSeries()),
    expect: () => [
      const WatchlistTvState(watchlistState: RequestState.Loading),
      const WatchlistTvState(
        watchlistState: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
    verify: (_) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );
}
