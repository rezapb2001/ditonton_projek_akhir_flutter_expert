import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'recommendation_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMoviesBloc recommendationMoviesBloc;
  late MockGetMovieRecommendations mockGetRecommendationMovies;

  setUp(() {
    mockGetRecommendationMovies = MockGetMovieRecommendations();
    recommendationMoviesBloc = RecommendationMoviesBloc(mockGetRecommendationMovies);
  });

  const id = 1;

  test('initial state should be empty', () {
    expect(recommendationMoviesBloc.state, RecommendationMoviesEmpty());
  });

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'Should emit [RecommendationMoviesLoading, RecommendationMoviesHasData] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationMovies.execute(id)).thenAnswer((_) async => Right(testMovieList));
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationMovies(id)),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovies.execute(id));
    },
  );

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'Should emit [RecommendationMoviesLoading, RecommendationMoviesError] when get data is unsuccessful',
    build: () {
      when(mockGetRecommendationMovies.execute(id)).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationMovies(id)),
    expect: () => [
      RecommendationMoviesLoading(),
      const RecommendationMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationMovies.execute(id));
    },
  );
}
