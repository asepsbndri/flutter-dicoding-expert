import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'tv_series_list_bloc_test.mocks.dart';


@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesBloc popularTvSeriesBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesBloc = PopularTvSeriesBloc(mockGetPopularTvSeries);
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/path.jpg",
    firstAirDate: "2020-01-01",
    genreIds: [1, 2, 3],
    id: 1,
    name: "Test TV Series",
    originalName: "Original Test TV Series",
    overview: "Overview of the test TV series",
    popularity: 123.4,
    posterPath: "/poster.jpg",
    voteAverage: 8.5,
    voteCount: 100,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('initial state harus PopularTvSeriesState.initial()', () {
    expect(popularTvSeriesBloc.state, PopularTvSeriesState.initial());
  });

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'emits [Loading, Loaded] ketika data populer berhasil diambil',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvSeriesState.initial().copyWith(state: RequestState.Loading),
      PopularTvSeriesState.initial().copyWith(
        state: RequestState.Loaded,
        tvSeries: tTvSeriesList,
      ),
    ],
    verify: (_) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvSeriesBloc, PopularTvSeriesState>(
    'emits [Loading, Error] ketika gagal mengambil data populer',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure("Server Failure")));
      return popularTvSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvSeries()),
    expect: () => [
      PopularTvSeriesState.initial().copyWith(state: RequestState.Loading),
      PopularTvSeriesState.initial().copyWith(
        state: RequestState.Error,
        message: "Server Failure",
      ),
    ],
    verify: (_) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
