import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable.toJson()))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable.toJson()))
          .thenThrow(Exception());
      // act & assert
      expect(
        () async => await dataSource.insertWatchlist(testMovieTable),
        throwsA(isA<DatabaseException>()),
      );
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable.id, 'movie'))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testMovieTable.id, 'movie'))
          .thenThrow(Exception());
      // act & assert
      expect(
        () async => await dataSource.removeWatchlist(testMovieTable),
        throwsA(isA<DatabaseException>()),
      );
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getItemById(tId, 'movie'))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });
}
