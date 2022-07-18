import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetTopRatedTvShows {
  final TvRepository _repository;

  GetTopRatedTvShows(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getTopRatedTvShows();
  }
}
