import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/path/to/backdrop.jpg",
    genreIds: [18, 80],
    id: 1,
    originalName: "Original Name",
    name: "Tv Series Name",
    overview: "This is a test overview for the TV series.",
    popularity: 100.0,
    posterPath: "/path/to/poster.jpg",
    firstAirDate: "2023-01-01",
    voteAverage: 8.5,
    voteCount: 1000,
  );

  final tTvSeriesList = [tTvSeries];
  final tQuery = "Squid Game";

  test('should return list of TvSeries when search is successful', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTvSeriesList));

    // act
    final result = await usecase.execute(tQuery);

    // assert
    expect(result, Right(tTvSeriesList));
    verify(mockTvSeriesRepository.searchTvSeries(tQuery));
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });

  test('should return Failure when search is unsuccessful', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Left(ServerFailure("Server Failure")));

    // act
    final result = await usecase.execute(tQuery);

    // assert
    expect(result, Left(ServerFailure("Server Failure")));
    verify(mockTvSeriesRepository.searchTvSeries(tQuery));
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });
}
