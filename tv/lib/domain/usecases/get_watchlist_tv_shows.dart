import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetWatchlistTvShows {
  final TvRepository _repository;

  GetWatchlistTvShows(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTvShows();
  }
}
