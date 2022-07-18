import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvShows _tvSearch;

  TvSearchBloc(this._tvSearch) : super(TvSearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvSearchLoading());
      final result = await _tvSearch.execute(query);

      result.fold(
        (failure) {
          emit(TvSearchError(failure.message));
        },
        (data) {
          emit(TvSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
