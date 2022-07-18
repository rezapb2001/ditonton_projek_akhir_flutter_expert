import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

@GenerateMocks([
  DatabaseTvHelper,
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseMovieHelper,
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
