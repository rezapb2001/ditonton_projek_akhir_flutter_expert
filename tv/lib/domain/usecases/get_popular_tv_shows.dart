import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetPopularTvShows {
  final TvRepository _repository;

  GetPopularTvShows(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getPopularTvShows();
  }
}
