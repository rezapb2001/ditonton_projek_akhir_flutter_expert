import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv/dummy_objects.dart';
import 'tv_on_the_air_bloc_test.mocks.dart';

@GenerateMocks([GetTvOnTheAir])
void main() {
  late TvOnTheAirBloc tvOnTheAirBloc;
  late MockGetTvOnTheAir mockGetTvOnTheAir;

  setUp(() {
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    tvOnTheAirBloc = TvOnTheAirBloc(mockGetTvOnTheAir);
  });

  test('initial state should be empty', () {
    expect(tvOnTheAirBloc.state, TvOnTheAirEmpty());
  });

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'Should emit [TvOnTheAirLoading, TvOnTheAirHasData] when data is gotten successfully',
    build: () {
      when(mockGetTvOnTheAir.execute()).thenAnswer((_) async => Right(testTvList));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvOnTheAir()),
    expect: () => [
      TvOnTheAirLoading(),
      TvOnTheAirHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute());
    },
  );

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'Should emit [OnTheAirTvsLoading, OnTheAirTvsError] when get data is unsuccessful',
    build: () {
      when(mockGetTvOnTheAir.execute()).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvOnTheAir()),
    expect: () => [
      TvOnTheAirLoading(),
      const TvOnTheAirError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute());
    },
  );
}
