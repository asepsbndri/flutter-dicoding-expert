import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_airing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_bloc_test.mocks.dart';


@GenerateMocks([
  GetOnAiringTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late TvSeriesListBloc bloc;
  late MockGetOnAiringTvSeries mockOnAiring;
  late MockGetPopularTvSeries mockPopular;
  late MockGetTopRatedTvSeries mockTopRated;

  setUp(() {
    mockOnAiring = MockGetOnAiringTvSeries();
    mockPopular = MockGetPopularTvSeries();
    mockTopRated = MockGetTopRatedTvSeries();
    bloc = TvSeriesListBloc(
      getOnAiringTvSeries: mockOnAiring,
      getPopularTvSeries: mockPopular,
      getTopRatedTvSeries: mockTopRated,
    );
  });

  final tTvSeries = TvSeries(
    adult: false,
    genreIds: const [1, 2],
    id: 1,
    name: 'Test Series',
    overview: 'Overview',
    posterPath: '/poster.jpg',
    firstAirDate: '2020-01-01',
    voteAverage: 8.0,
    voteCount: 100,
    popularity: 50,
    backdropPath: '/backdrop.jpg',
    originalName: 'Original Test',
  );

  group('On Airing TV Series', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'emits [Loading, Loaded] when FetchOnAiringTvSeries succeeds',
      build: () {
        when(mockOnAiring.execute())
            .thenAnswer((_) async => Right([tTvSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnAiringTvSeries()),
      expect: () => [
        const TvSeriesListState(onAiringState: RequestState.Loading),
        TvSeriesListState(
          onAiringState: RequestState.Loaded,
          onAiringTvSeries: [tTvSeries],
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'emits [Loading, Error] when FetchOnAiringTvSeries fails',
      build: () {
        when(mockOnAiring.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnAiringTvSeries()),
      expect: () => [
        const TvSeriesListState(onAiringState: RequestState.Loading),
        const TvSeriesListState(
          onAiringState: RequestState.Error,
          message: 'Server Error',
        ),
      ],
    );
  });

  group('Popular TV Series', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'emits [Loading, Loaded] when FetchPopularTvSeries succeeds',
      build: () {
        when(mockPopular.execute())
            .thenAnswer((_) async => Right([tTvSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        const TvSeriesListState(popularTvSeriesState: RequestState.Loading),
        TvSeriesListState(
          popularTvSeriesState: RequestState.Loaded,
          popularTvSeries: [tTvSeries],
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'emits [Loading, Error] when FetchPopularTvSeries fails',
      build: () {
        when(mockPopular.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularTvSeries()),
      expect: () => [
        const TvSeriesListState(popularTvSeriesState: RequestState.Loading),
        const TvSeriesListState(
          popularTvSeriesState: RequestState.Error,
          message: 'Server Error',
        ),
      ],
    );
  });

  group('Top Rated TV Series', () {
    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'emits [Loading, Loaded] when FetchTopRatedTvSeries succeeds',
      build: () {
        when(mockTopRated.execute())
            .thenAnswer((_) async => Right([tTvSeries]));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        const TvSeriesListState(topRatedTvSeriesState: RequestState.Loading),
        TvSeriesListState(
          topRatedTvSeriesState: RequestState.Loaded,
          topRatedTvSeries: [tTvSeries],
        ),
      ],
    );

    blocTest<TvSeriesListBloc, TvSeriesListState>(
      'emits [Loading, Error] when FetchTopRatedTvSeries fails',
      build: () {
        when(mockTopRated.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTvSeries()),
      expect: () => [
        const TvSeriesListState(topRatedTvSeriesState: RequestState.Loading),
        const TvSeriesListState(
          topRatedTvSeriesState: RequestState.Error,
          message: 'Server Error',
        ),
      ],
    );
  });
}
