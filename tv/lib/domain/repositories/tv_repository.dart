import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

abstract class TvRepository {

  Future<Either<Failure, List<Tv>>> getTvOnTheAir();
  Future<Either<Failure, List<Tv>>> getPopularTvShows();
  Future<Either<Failure, List<Tv>>> getTopRatedTvShows();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tv>>> searchTvShows(String query);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail tv);
  Future<bool> isAddedTvToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getWatchlistTvShows();
}
