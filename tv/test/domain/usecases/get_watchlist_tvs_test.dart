import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../dummy_data/tv/dummy_objects.dart';


void main() {
  late GetWatchlistTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTvShows(mockTvRepository);
  });

  test('should get list of Tvs from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTvShows()).thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
