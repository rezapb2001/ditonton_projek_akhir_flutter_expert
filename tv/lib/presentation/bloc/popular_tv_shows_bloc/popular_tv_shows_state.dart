part of 'popular_tv_shows_bloc.dart';

abstract class PopularTvShowsState extends Equatable {
  const PopularTvShowsState();

  @override
  List<Object?> get props => [];
}

class PopularTvShowsEmpty extends PopularTvShowsState {}

class PopularTvShowsLoading extends PopularTvShowsState {}

class PopularTvShowsHasData extends PopularTvShowsState {
  final List<Tv> result;

  const PopularTvShowsHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class PopularTvShowsError extends PopularTvShowsState {
  final String message;

  const PopularTvShowsError(this.message);

  @override
  List<Object?> get props => [message];
}
