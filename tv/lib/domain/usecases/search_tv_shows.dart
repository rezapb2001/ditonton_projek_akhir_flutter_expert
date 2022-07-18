import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class SearchTvShows {
  final TvRepository repository;

  SearchTvShows(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvShows(query);
  }
}
