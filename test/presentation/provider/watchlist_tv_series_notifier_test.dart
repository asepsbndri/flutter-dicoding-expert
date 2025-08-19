import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late WatchlistTvSeriesNotifier provider;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    provider = WatchlistTvSeriesNotifier(getWatchlistTvSeries: mockGetWatchlistTvSeries);
    listenerCallCount = 0;
    provider.addListener(() {
      listenerCallCount++;
    });
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "backdropPath",
    firstAirDate: "2020-05-05",
    genreIds: [1, 2, 3],
    id: 1,
    name: "Test Series",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 123.4,
    posterPath: "posterPath",
    voteAverage: 8.0,
    voteCount: 200,
  );

  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('get watchlist tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchWatchlistTvSeries();
      // assert
      expect(provider.watchlistState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should return tv series list when data is successfully fetched', () async {
      // arrange
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchWatchlistTvSeries();
      // assert
      expect(provider.watchlistState, RequestState.Loaded);
      expect(provider.watchlistTvSeries, tTvSeriesList);
      expect(listenerCallCount, greaterThan(1));
    });

    test('should return error when data fetching fails', () async {
      // arrange
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Database Failure")));
      // act
      await provider.fetchWatchlistTvSeries();
      // assert
      expect(provider.watchlistState, RequestState.Error);
      expect(provider.message, "Database Failure");
      expect(listenerCallCount, greaterThan(1));
    });
  });
}
