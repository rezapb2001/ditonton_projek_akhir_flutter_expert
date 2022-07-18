import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:dartz/dartz.dart';

import 'search_tv_shows_bloc_test.mocks.dart';

final tTvModel = Tv(
  backdropPath: '/path.jpg',
  genreIds: const [1],
  id: 1,
  name: 'name',
  originalLanguage: 'en',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  voteAverage: 1.0,
  voteCount: 1,
);

final tTvList = <Tv>[tTvModel];
const tQuery = 'Moon Knight';

@GenerateMocks([SearchTvShows])
void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTvShows mockTvSearch;

  setUp(() {
    mockTvSearch = MockSearchTvShows();
    tvSearchBloc = TvSearchBloc(mockTvSearch);
  });

  test('initial state should be empty', () {
    expect(tvSearchBloc.state, TvSearchEmpty());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockTvSearch.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      TvSearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockTvSearch.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockTvSearch.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      const TvSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockTvSearch.execute(tQuery));
    },
  );
}
