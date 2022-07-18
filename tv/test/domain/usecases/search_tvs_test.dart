import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvShows(mockTvRepository);
  });

  final tTvs = <Tv>[];
  const tvQuery = 'Moon Knight';

  test('should get list of tvs from the repository', () async {
    // arrange
    when(mockTvRepository.searchTvShows(tvQuery)).thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute(tvQuery);
    // assert
    expect(result, Right(tTvs));
  });
}
