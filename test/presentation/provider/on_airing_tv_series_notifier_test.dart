import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_airing_tv_series.dart';
import 'package:ditonton/presentation/provider/on_airing_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_airing_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetOnAiringTvSeries])
void main() {
  late OnAiringTvSeriesNotifier provider;
  late MockGetOnAiringTvSeries mockGetOnAiringTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAiringTvSeries = MockGetOnAiringTvSeries();
    provider = OnAiringTvSeriesNotifier(mockGetOnAiringTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: 'backdropPath',
    firstAirDate: '2020-05-05',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Test Series',

    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 10.0,
    posterPath: 'posterPath',
    voteAverage: 8.0,
    voteCount: 100,
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('fetch On Airing Tv Series', () {
    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetOnAiringTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchOnAiringTvSeries();
      // assert
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvSeries when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAiringTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchOnAiringTvSeries();
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAiringTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAiringTvSeries();
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
