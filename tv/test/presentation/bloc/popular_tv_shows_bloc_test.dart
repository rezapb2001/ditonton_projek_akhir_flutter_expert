import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/dummy_objects.dart';
import 'popular_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late PopularTvShowsBloc popularTvShowsBloc;
  late MockGetPopularTvShows mockGetPopularTvShows;

  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvShowsBloc = PopularTvShowsBloc(mockGetPopularTvShows);
  });

  test('initial state should be empty', () {
    expect(popularTvShowsBloc.state, PopularTvShowsEmpty());
  });

  blocTest<PopularTvShowsBloc, PopularTvShowsState>(
    'Should emit [PopularTvShowsLoading, PopularTvShowsHasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvShows.execute()).thenAnswer((_) async => Right(testTvList));
      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvShows()),
    expect: () => [
      PopularTvShowsLoading(),
      PopularTvShowsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );

  blocTest<PopularTvShowsBloc, PopularTvShowsState>(
    'Should emit [PopularTvShowsLoading, PopularTvShowsError] when get data is unsuccessful',
    build: () {
      when(mockGetPopularTvShows.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTvShows()),
    expect: () => [
      PopularTvShowsLoading(),
      const PopularTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );
}
