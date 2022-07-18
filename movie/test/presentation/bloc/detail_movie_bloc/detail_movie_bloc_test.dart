import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMovieBloc detailMovieBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  const int id = 1;

  test('initial state should be empty', () {
    expect(detailMovieBloc.state, DetailMovieEmpty());
  });

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [DetailMovieLoading, DetailMovieHasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(id)).thenAnswer((_) async => const Right(testMovieDetail));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailMovie(id)),
    expect: () => [
      DetailMovieLoading(),
      const DetailMovieHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
    },
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'Should emit [DetailMovieLoading, DetailMovieError] when get data is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(id)).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(const FetchDetailMovie(id)),
    expect: () => [
      DetailMovieLoading(),
      const DetailMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(id));
    },
  );
}
