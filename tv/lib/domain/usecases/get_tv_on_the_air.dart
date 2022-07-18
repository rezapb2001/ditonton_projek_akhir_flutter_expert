import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetTvOnTheAir {
  final TvRepository _repository;

  GetTvOnTheAir(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getTvOnTheAir();
  }
}
