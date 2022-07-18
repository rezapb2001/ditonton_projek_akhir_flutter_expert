part of 'top_rated_tv_shows_bloc.dart';

abstract class TopRatedTvShowsEvent extends Equatable {
  const TopRatedTvShowsEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRatedTvShows extends TopRatedTvShowsEvent {}
