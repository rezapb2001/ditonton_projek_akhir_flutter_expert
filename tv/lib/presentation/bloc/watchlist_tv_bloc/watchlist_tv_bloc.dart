import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvShows _getWatchlistTv;
  final SaveTvWatchlist _saveWatchlistTv;
  final RemoveTvWatchlist _removeWatchlistTv;
  final GetWatchListTvStatus _getWatchListStatusTv;

  WatchlistTvBloc(this._getWatchlistTv, this._saveWatchlistTv, this._removeWatchlistTv, this._getWatchListStatusTv)
      : super(WatchlistTvEmpty()) {
    on<FetchWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await _getWatchlistTv.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvError(failure.message));
        },
        (data) {
          emit(WatchlistTvHasData(data));
        },
      );
    });

    on<AddWatchListTv>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await _saveWatchlistTv.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvMessageFailure(failure.message));
        },
        (successMessage) {
          emit(const WatchlistTvMessageSuccess('Added To Watchlist'));
        },
      );
      add(LoadWatchlistStatusTv(tvDetail.id));
    });

    on<RemoveFromWatchListTv>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await _removeWatchlistTv.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvMessageFailure(failure.message));
        },
        (successMessage) {
          emit(const WatchlistTvMessageSuccess('Removed From Watchlist'));
        },
      );
      add(LoadWatchlistStatusTv(tvDetail.id));
    });

    on<LoadWatchlistStatusTv>((event, emit) async {
      final id = event.id;
      final result = await _getWatchListStatusTv.execute(id);

      emit(WatchlistTvStatus(result));
    });
  }
}
