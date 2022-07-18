part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovies extends WatchlistMoviesEvent {}

class AddWatchListMovie extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;

  const AddWatchListMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchListMovie extends WatchlistMoviesEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchListMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatus extends WatchlistMoviesEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
