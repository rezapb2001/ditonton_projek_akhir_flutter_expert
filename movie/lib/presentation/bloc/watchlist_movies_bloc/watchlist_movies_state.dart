part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  final List<Movie> result;

  const WatchlistMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMessageSuccess extends WatchlistMoviesState {
  final String message;

  const WatchlistMessageSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMessageFailure extends WatchlistMoviesState {
  final String message;

  const WatchlistMessageFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatus extends WatchlistMoviesState {
  final bool isAddedToWatchlist;

  const WatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
