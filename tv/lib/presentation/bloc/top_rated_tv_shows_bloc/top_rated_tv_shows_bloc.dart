import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_shows_event.dart';
part 'top_rated_tv_shows_state.dart';

class TopRatedTvShowsBloc extends Bloc<TopRatedTvShowsEvent, TopRatedTvShowsState> {
  final GetTopRatedTvShows _getTopRatedTvShows;

  TopRatedTvShowsBloc(this._getTopRatedTvShows) : super(TopRatedTvShowsEmpty()) {
    on<FetchTopRatedTvShows>((event, emit) async {
      emit(TopRatedTvShowsLoading());
      final result = await _getTopRatedTvShows.execute();

      result.fold(
        (failure) {
          emit(TopRatedTvShowsError(failure.message));
        },
        (data) {
          emit(TopRatedTvShowsHasData(data));
        },
      );
    });
  }
}
