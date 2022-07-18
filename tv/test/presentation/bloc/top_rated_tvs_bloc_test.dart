import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/dummy_objects.dart';
import 'top_rated_tvs_bloc_test.mocks.dart';


@GenerateMocks([GetTopRatedTvShows])
void main() {
  late TopRatedTvShowsBloc res;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    res = TopRatedTvShowsBloc(mockGetTopRatedTvShows);
  });

  test('initial state should be empty', () {
    expect(res.state, TopRatedTvShowsEmpty());
  });

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'Should emit [TopRatedTvShowsLoading, TopRatedTvShowsHasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvShows.execute()).thenAnswer((_) async => Right(testTvList));
      return res;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvShows()),
    expect: () => [
      TopRatedTvShowsLoading(),
      TopRatedTvShowsHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'Should emit [TopRatedTvShowsLoading, TopRatedTvShowsError] when get data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvShows.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return res;
    },
    act: (bloc) => bloc.add(FetchTopRatedTvShows()),
    expect: () => [
      TopRatedTvShowsLoading(),
      const TopRatedTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );
}
