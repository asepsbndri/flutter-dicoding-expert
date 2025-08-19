import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: "/path.jpg",
    firstAirDate: "2021-09-17",
    genreIds: [18],
    id: 1,
    name: "Squid Game",
    originalName: "오징어 게임",
    overview: "Hundreds of cash-strapped players...",
    popularity: 1000.0,
    posterPath: "/poster.jpg",
    voteAverage: 8.5,
    voteCount: 5000,
  );

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/path.jpg",
    firstAirDate: "2021-09-17",
    genreIds: [18],
    id: 1,
    name: "Squid Game",
    originalName: "오징어 게임",
    overview: "Hundreds of cash-strapped players...",
    popularity: 1000.0,
    posterPath: "/poster.jpg",
    voteAverage: 8.5,
    voteCount: 5000,
  );

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('On The Air TvSeries', () {
    test('should return tv series list when call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getOnAiringTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getOnAiringTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockRemoteDataSource.getOnAiringTvSeries())
          .thenThrow(ServerException());
      final result = await repository.getOnAiringTvSeries();
      expect(result, Left(ServerFailure('')));
    });

    test('should return ConnectionFailure when no internet', () async {
      when(mockRemoteDataSource.getOnAiringTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repository.getOnAiringTvSeries();
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Popular TvSeries', () {
    test('should return tv series list when call is successful', () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      final result = await repository.getPopularTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      final result = await repository.getPopularTvSeries();
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Top Rated TvSeries', () {
    test('should return tv series list when call is successful', () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      final result = await repository.getTopRatedTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      final result = await repository.getTopRatedTvSeries();
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Get TvSeries Detail', () {
    final tId = 1;
    final tTvSeriesDetailResponse = TvSeriesDetailResponse(
      adult: false,
      productionCompanies: ["us"],
      productionCountries: ["KR"],
      spokenLanguages: ["ko"],
      backdropPath: "backdropPath",
      episodeRunTime: [60],
      firstAirDate: "2021-09-17",
      genres: [GenreModel(id: 1, name: "Drama")],
      homepage: "https://netflix.com",
      id: 1,
      inProduction: false,
      languages: ["ko"],
      lastAirDate: "2021-09-17",
      name: "Squid Game",
      numberOfEpisodes: 9,
      numberOfSeasons: 1,
      originCountry: ["KR"],
      originalLanguage: "ko",
      originalName: "오징어 게임",
      overview: "Hundreds of cash-strapped players...",
      popularity: 1000,
      posterPath: "posterPath",
      status: "Ended",
      tagline: "Survive or die",
      type: "Scripted",
      voteAverage: 8.5,
      voteCount: 5000,
    );

    test('should return TvSeriesDetail when call is successful', () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tTvSeriesDetailResponse);
      final result = await repository.getTvSeriesDetail(tId);
      expect(result, Right(testTvSeriesDetail));
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      final result = await repository.getTvSeriesDetail(tId);
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Get TvSeries Recommendations', () {
    final tId = 1;
    final tTvSeriesModelList = <TvSeriesModel>[];

    test('should return tv series list when call is successful', () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => tTvSeriesModelList);
      final result = await repository.getTvSeriesRecommendations(tId);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesModelList);
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());
      final result = await repository.getTvSeriesRecommendations(tId);
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Search TvSeries', () {
    final tQuery = "squid";

    test('should return tv series list when call is successful', () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      final result = await repository.searchTvSeries(tQuery);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call is unsuccessful', () async {
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      final result = await repository.searchTvSeries(tQuery);
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Watchlist', () {
    test('should return success when save is successful', () async {
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => "Added to Watchlist");
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      expect(result, Right("Added to Watchlist"));
    });

    test('should return DatabaseFailure when save is unsuccessful', () async {
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });

    test('should return success when remove is successful', () async {
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => "Removed from Watchlist");
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      expect(result, Right("Removed from Watchlist"));
    });

    test('should return DatabaseFailure when remove is unsuccessful', () async {
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });

    test('should return watchlist status true when data found', () async {
      final tId = 1;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesTable);
      final result = await repository.isAddedToWatchlist(tId);
      expect(result, true);
    });

    test('should return tv series watchlist', () async {
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);
      final result = await repository.getWatchlistTvSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
