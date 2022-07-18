import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/dummy_objects.dart';
import 'watchlist_tvs_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvShows,
  SaveTvWatchlist,
  RemoveTvWatchlist,
  GetWatchListTvStatus
])
void main() { 
  late WatchlistTvBloc watchlistTvShowsBloc;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;

  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    watchlistTvShowsBloc = WatchlistTvBloc(
      mockGetWatchlistTvShows,
      mockSaveTvWatchlist,
      mockRemoveTvWatchlist,
      mockGetWatchListTvStatus,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistTvShowsBloc.state, WatchlistTvEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [WatchlistTvLoading, WatchlistTvHasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right(testTvList));
      return watchlistTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [WatchlistTvLoading, WatchlistTvError] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistTvShowsBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      const WatchlistTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );
}
