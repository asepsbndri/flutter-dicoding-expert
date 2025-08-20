import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_airing_tv_series.dart';
import 'package:ditonton/presentation/bloc/on_airing_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/on_airing_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/on_airing_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_bloc_test.mocks.dart';


@GenerateMocks([GetOnAiringTvSeries])
void main() {
  late OnAiringTvSeriesBloc bloc;
  late MockGetOnAiringTvSeries mockGetOnAiringTvSeries;

  setUp(() {
    mockGetOnAiringTvSeries = MockGetOnAiringTvSeries();
    bloc = OnAiringTvSeriesBloc(mockGetOnAiringTvSeries);
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    firstAirDate: '2020-01-01',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Test Series',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    voteAverage: 8.5,
    voteCount: 100,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('initial state harus OnAiringTvSeriesState default', () {
    expect(bloc.state, const OnAiringTvSeriesState());
  });

  blocTest<OnAiringTvSeriesBloc, OnAiringTvSeriesState>(
    'emit [Loading, Loaded] ketika data berhasil diambil',
    build: () {
      when(mockGetOnAiringTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchOnAiringTvSeries()),
    expect: () => [
      const OnAiringTvSeriesState(state: RequestState.Loading),
      OnAiringTvSeriesState(
        state: RequestState.Loaded,
        tvSeries: tTvSeriesList,
      ),
    ],
    verify: (_) {
      verify(mockGetOnAiringTvSeries.execute());
    },
  );

  blocTest<OnAiringTvSeriesBloc, OnAiringTvSeriesState>(
    'emit [Loading, Error] ketika gagal ambil data',
    build: () {
      when(mockGetOnAiringTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchOnAiringTvSeries()),
    expect: () => [
      const OnAiringTvSeriesState(state: RequestState.Loading),
      const OnAiringTvSeriesState(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
    verify: (_) {
      verify(mockGetOnAiringTvSeries.execute());
    },
  );
}
