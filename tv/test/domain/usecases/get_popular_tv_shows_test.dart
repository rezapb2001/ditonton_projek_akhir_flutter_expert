import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShows usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTvShows(mockTvRepository);
  });

  final tTvs = <Tv>[];

  test('should get list of tv from the repository when execute function is called', () async {
    // arrange
    when(mockTvRepository.getPopularTvShows()).thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
