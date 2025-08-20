import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_bloc_test.mocks.dart';


@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchBloc bloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    bloc = TvSeriesSearchBloc(mockSearchTvSeries);
  });

  const testQuery = 'Breaking Bad';

  final testTvSeries = TvSeries(
    adult: false,
    id: 1,
    name: 'Breaking Bad',
    overview: 'Overview',
    posterPath: '/poster.jpg',
    backdropPath: '/backdrop.jpg',
    voteAverage: 9.0,
    voteCount: 100,
    firstAirDate: '2008-01-01',
    genreIds: const [1, 2],
    originalName: 'Breaking Bad',
    popularity: 99.9,
  );

  final testTvSeriesList = <TvSeries>[testTvSeries];

  test('initial state should be TvSeriesSearchEmpty', () {
    expect(bloc.state, TvSeriesSearchEmpty());
  });

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'emits [Loading, HasData] when search succeeds',
    build: () {
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnTvSeriesQueryChanged(testQuery)),
    wait: const Duration(milliseconds: 500), // debounce kalau ada
    expect: () => [
      TvSeriesSearchLoading(),
      TvSeriesSearchHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(testQuery));
    },
  );

  blocTest<TvSeriesSearchBloc, TvSeriesSearchState>(
    'emits [Loading, Error] when search fails',
    build: () {
      when(mockSearchTvSeries.execute(testQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnTvSeriesQueryChanged(testQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSeriesSearchLoading(),
      const TvSeriesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(testQuery));
    },
  );
}
