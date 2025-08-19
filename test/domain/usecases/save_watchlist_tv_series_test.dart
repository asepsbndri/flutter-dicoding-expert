import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockTvSeriesRepository);
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

  test('should save tv series to watchlist when success', () async {
    // arrange
    when(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail))
        .thenAnswer((_) async => const Right("Added to Watchlist"));

    // act
    final result = await usecase.execute(tTvSeriesDetail);

    // assert
    expect(result, const Right("Added to Watchlist"));
    verify(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail));
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });

  test('should return DatabaseFailure when saving to watchlist is unsuccessful', () async {
    // arrange
    when(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail))
        .thenAnswer((_) async => Left(DatabaseFailure("Failed to add watchlist")));

    // act
    final result = await usecase.execute(tTvSeriesDetail);

    // assert
    expect(result, Left(DatabaseFailure("Failed to add watchlist")));
    verify(mockTvSeriesRepository.saveWatchlist(tTvSeriesDetail));
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });
}
