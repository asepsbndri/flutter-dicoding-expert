import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    id: 1,
    originalName: 'originalName',
    name: 'name',
    overview: 'overview',
    popularity: 1,
    backdropPath: 'backdropPath',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    voteAverage: 1,
    voteCount: 1,
    adult: false,
  );

  final tTvSeries = TvSeries(
    id: 1,
    originalName: 'originalName',
    name: 'name',
    overview: 'overview',
    popularity: 1,
    backdropPath: 'backdropPath',
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    voteAverage: 1,
    voteCount: 1,
    adult: false,
  );

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}