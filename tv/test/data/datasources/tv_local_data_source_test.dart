import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';


void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseTvHelper mockDatabaseTvHelper;

  setUp(() {
    mockDatabaseTvHelper = MockDatabaseTvHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseTvHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success', () async {
      // arrange
      when(mockDatabaseTvHelper.insertTvWatchlist(testTvTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertTvWatchlist(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseTvHelper.insertTvWatchlist(testTvTable)).thenThrow(Exception());
      // act
      final call = dataSource.insertTvWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success', () async {
      // arrange
      when(mockDatabaseTvHelper.removeTvWatchlist(testTvTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeTvWatchlist(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed', () async {
      // arrange
      when(mockDatabaseTvHelper.removeTvWatchlist(testTvTable)).thenThrow(Exception());
      // act
      final call = dataSource.removeTvWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    const tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseTvHelper.getTvById(tId)).thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseTvHelper.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseTvHelper.getWatchlistTvShows()).thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTvShows();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
