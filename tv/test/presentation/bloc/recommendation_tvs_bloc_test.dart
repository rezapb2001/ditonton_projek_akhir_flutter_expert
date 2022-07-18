import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/dummy_objects.dart';
import 'recommendation_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationsBloc tvRecommendationsBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationsBloc = TvRecommendationsBloc(mockGetTvRecommendations);
  });

  const id = 1;

  test('initial state should be empty', () {
    expect(tvRecommendationsBloc.state, TvRecommendationsEmpty());
  });

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'Should emit [TvRecommendationsLoading, TvRecommendationsHasData] when data is gotten successfully',
    build: () {
      when(mockGetTvRecommendations.execute(id)).thenAnswer((_) async => Right(testTvList));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(const FetchTvRecommendations(id)),
    expect: () => [
      TvRecommendationsLoading(),
      TvRecommendationsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(id));
    },
  );

  blocTest<TvRecommendationsBloc, TvRecommendationsState>(
    'Should emit [TvRecommendationsLoading, TvRecommendationsError] when get data is unsuccessful',
    build: () {
      when(mockGetTvRecommendations.execute(id)).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(const FetchTvRecommendations(id)),
    expect: () => [
      TvRecommendationsLoading(),
      const TvRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(id));
    },
  );
}
