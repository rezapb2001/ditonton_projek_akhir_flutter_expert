import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetTvRecommendations {
  final TvRepository _repository;

  GetTvRecommendations(this._repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return _repository.getTvRecommendations(id);
  }
}
