import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchListStatus _getWatchListStatus;

  WatchlistMoviesBloc(this._getWatchlistMovies, this._saveWatchlist, this._removeWatchlist, this._getWatchListStatus)
      : super(WatchlistMoviesEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistMoviesError(failure.message));
        },
        (data) {
          emit(WatchlistMoviesHasData(data));
        },
      );
    });

    on<AddWatchListMovie>(
      (event, emit) async {
        final movieDetail = event.movieDetail;
        final result = await _saveWatchlist.execute(movieDetail);

        result.fold(
          (failure) {
            emit(WatchlistMessageFailure(failure.message));
          },
          (successMessage) {
            emit(const WatchlistMessageSuccess('Added From Watchlist'));
          },
        );
        add(LoadWatchlistStatus(movieDetail.id));
      },
    );

    on<RemoveFromWatchListMovie>(
      (event, emit) async {
        final movieDetail = event.movieDetail;
        final result = await _removeWatchlist.execute(movieDetail);

        result.fold(
          (failure) {
            emit(WatchlistMessageFailure(failure.message));
          },
          (successMessage) {
            emit(const WatchlistMessageSuccess('Removed From Watchlist'));
          },
        );
        add(LoadWatchlistStatus(movieDetail.id));
      },
    );

    on<LoadWatchlistStatus>(
      (event, emit) async {
        final id = event.id;
        final result = await _getWatchListStatus.execute(id);

        emit(WatchlistStatus(result));
      },
    );
  }
}
