import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_shows_event.dart';
part 'popular_tv_shows_state.dart';

class PopularTvShowsBloc extends Bloc<PopularTvShowsEvent, PopularTvShowsState> {
  final GetPopularTvShows _getPopularTvShows;

  PopularTvShowsBloc(this._getPopularTvShows) : super(PopularTvShowsEmpty()) {
    on<FetchPopularTvShows>((event, emit) async {
      emit(PopularTvShowsLoading());
      final result = await _getPopularTvShows.execute();

      result.fold(
        (failure) {
          emit(PopularTvShowsError(failure.message));
        },
        (data) {
          emit(PopularTvShowsHasData(data));
        },
      );
    });
  }
}
