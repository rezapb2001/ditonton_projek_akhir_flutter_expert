part of 'top_rated_tv_shows_bloc.dart';

abstract class TopRatedTvShowsState extends Equatable {
  const TopRatedTvShowsState();

  @override
  List<Object> get props => [];
}

class TopRatedTvShowsEmpty extends TopRatedTvShowsState {}

class TopRatedTvShowsLoading extends TopRatedTvShowsState {}

class TopRatedTvShowsHasData extends TopRatedTvShowsState {
  final List<Tv> result;

  const TopRatedTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvShowsError extends TopRatedTvShowsState {
  final String message;

  const TopRatedTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}
