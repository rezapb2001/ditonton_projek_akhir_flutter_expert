part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTv extends WatchlistTvEvent {}

class AddWatchListTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const AddWatchListTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveFromWatchListTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const RemoveFromWatchListTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class LoadWatchlistStatusTv extends WatchlistTvEvent {
  final int id;

  const LoadWatchlistStatusTv(this.id);

  @override
  List<Object> get props => [id];
}
