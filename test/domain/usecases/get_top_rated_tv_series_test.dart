import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockTvSeriesRepository);
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

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('should get list of top rated tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tTvSeriesList));

    // act
    final result = await usecase.execute();

    // assert
    expect(result, Right(tTvSeriesList));
    verify(mockTvSeriesRepository.getTopRatedTvSeries());
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });
}
