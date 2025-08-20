import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_detail_bloc_test.mocks.dart';


@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetWatchlistTvSeriesStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailBloc bloc;
  late MockGetTvSeriesDetail mockGetDetail;
  late MockGetTvSeriesRecommendations mockGetRecommendations;
  late MockGetWatchlistTvSeriesStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlist;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlist;

  setUp(() {
    mockGetDetail = MockGetTvSeriesDetail();
    mockGetRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchlistTvSeriesStatus();
    mockSaveWatchlist = MockSaveWatchlistTvSeries();
    mockRemoveWatchlist = MockRemoveWatchlistTvSeries();

    bloc = TvSeriesDetailBloc(
      getTvSeriesDetail: mockGetDetail,
      getTvSeriesRecommendations: mockGetRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2],
    id: 1,
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: '2020-01-01',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
    originalName: 'originalName',
  );

  final tTvDetail = TvSeriesDetail(
    firstAirDate: '2020-01-01',
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tRecommendations = <TvSeries>[tTvSeries];

  test('initial state should be empty', () {
    expect(bloc.state, const TvSeriesDetailState());
  });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'emits [Loading, Loaded detail + Loading rec, Loaded recs] when FetchTvSeriesDetailEvent succeeds',
    build: () {
      when(mockGetDetail.execute(tId))
          .thenAnswer((_) async => Right(tTvDetail));
      when(mockGetRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tRecommendations));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesDetailEvent(tId)),
    expect: () => [
      const TvSeriesDetailState(tvSeriesState: RequestState.Loading),
      TvSeriesDetailState(
        tvSeries: tTvDetail,
        tvSeriesState: RequestState.Loaded,
        recommendationState: RequestState.Loading,
      ),
      TvSeriesDetailState(
        tvSeries: tTvDetail,
        tvSeriesState: RequestState.Loaded,
        recommendationState: RequestState.Loaded,
        recommendations: tRecommendations,
      ),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'emits [Loading, Error] when FetchTvSeriesDetailEvent fails',
    build: () {
      when(mockGetDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tRecommendations));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesDetailEvent(tId)),
    expect: () => [
      const TvSeriesDetailState(tvSeriesState: RequestState.Loading),
      const TvSeriesDetailState(
        tvSeriesState: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'emits [Loaded detail, Error recs] when recommendations fail',
    build: () {
      when(mockGetDetail.execute(tId))
          .thenAnswer((_) async => Right(tTvDetail));
      when(mockGetRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed recs')));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTvSeriesDetailEvent(tId)),
    expect: () => [
      const TvSeriesDetailState(tvSeriesState: RequestState.Loading),
      TvSeriesDetailState(
        tvSeries: tTvDetail,
        tvSeriesState: RequestState.Loaded,
        recommendationState: RequestState.Loading,
      ),
      TvSeriesDetailState(
        tvSeries: tTvDetail,
        tvSeriesState: RequestState.Loaded,
        recommendationState: RequestState.Error,
        message: 'Failed recs',
      ),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'emits [Added] when AddWatchlistTvSeriesEvent succeeds',
    build: () {
      when(mockSaveWatchlist.execute(tTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      return bloc;
    },
    act: (bloc) => bloc.add(AddWatchlistTvSeriesEvent(tTvDetail)),
    expect: () => [
      const TvSeriesDetailState(
        watchlistMessage: 'Added to Watchlist',
        isAddedToWatchlist: true,
      ),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'emits [Removed] when RemoveWatchlistTvSeriesEvent succeeds',
    build: () {
      when(mockRemoveWatchlist.execute(tTvDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveWatchlistTvSeriesEvent(tTvDetail)),
    expect: () => [
      const TvSeriesDetailState(
        watchlistMessage: 'Removed from Watchlist',
        isAddedToWatchlist: false,
      ),
    ],
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'emits [isAddedToWatchlist true] when LoadWatchlistStatusTvSeriesEvent returns true',
    build: () {
      when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadWatchlistStatusTvSeriesEvent(tId)),
    expect: () => [
      const TvSeriesDetailState(isAddedToWatchlist: true),
    ],
  );
}
