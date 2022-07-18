import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetTvDetail {
  final TvRepository _repository;

  GetTvDetail(this._repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return _repository.getTvDetail(id);
  }
}
