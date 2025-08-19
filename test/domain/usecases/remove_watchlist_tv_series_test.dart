import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  final tTvSeriesDetail = TvSeriesDetail(
    id: 1,
    name: "Squid Game",
    overview: "Hundreds of cash-strapped players...",
    posterPath: "posterPath",
    backdropPath: "backdropPath",
    voteAverage: 8.5,
    voteCount: 5000,
    genres: [Genre(id: 1, name: "Drama")],
    firstAirDate: "2021-09-17",
    numberOfSeasons: 1,
    numberOfEpisodes: 9,
  );

  test('should remove watchlist tv series from repository when success', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchlist(tTvSeriesDetail))
        .thenAnswer((_) async => const Right("Removed from Watchlist"));

    // act
    final result = await usecase.execute(tTvSeriesDetail);

    // assert
    expect(result, const Right("Removed from Watchlist"));
    verify(mockTvSeriesRepository.removeWatchlist(tTvSeriesDetail));
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });

  test('should return DatabaseFailure when remove watchlist is unsuccessful', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchlist(tTvSeriesDetail))
        .thenAnswer((_) async => Left(DatabaseFailure("Failed to remove watchlist")));

    // act
    final result = await usecase.execute(tTvSeriesDetail);

    // assert
    expect(result, Left(DatabaseFailure("Failed to remove watchlist")));
    verify(mockTvSeriesRepository.removeWatchlist(tTvSeriesDetail));
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });
}
