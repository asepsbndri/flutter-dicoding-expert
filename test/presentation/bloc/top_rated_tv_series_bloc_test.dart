import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesBloc = TopRatedTvSeriesBloc(mockGetTopRatedTvSeries);
  });

  const tId = 1;
  final tTvSeries = TvSeries(
    adult: false,
    id: tId,
    name: 'Test Series',
    overview: 'Overview',
    posterPath: '/path.jpg',
    firstAirDate: '2020-01-01',
    voteAverage: 8.0,
    voteCount: 100,
    genreIds: const [1, 2],
    backdropPath: '/backdrop.jpg',
    popularity: 100.0,
    originalName: 'Original Title',
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('initial state should be empty', () {
    expect(topRatedTvSeriesBloc.state, const TopRatedTvSeriesState());
  });

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'emits [Loading, Loaded] when data is fetched successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      const TopRatedTvSeriesState(state: RequestState.Loading),
      TopRatedTvSeriesState(
        state: RequestState.Loaded,
        tvSeries: tTvSeriesList,
      ),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
    'emits [Loading, Error] when data fetch fails',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
    expect: () => [
      const TopRatedTvSeriesState(state: RequestState.Loading),
      const TopRatedTvSeriesState(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
