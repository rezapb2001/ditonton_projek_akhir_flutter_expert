part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvHasData extends WatchlistTvState {
  final List<Tv> result;

  const WatchlistTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTvError extends WatchlistTvState {
  final String message;

  const WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvMessageSuccess extends WatchlistTvState {
  final String message;

  const WatchlistTvMessageSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvMessageFailure extends WatchlistTvState {
  final String message;

  const WatchlistTvMessageFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvStatus extends WatchlistTvState {
  final bool isAddedToWatchlist;

  const WatchlistTvStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
