import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_on_the_air_event.dart';
part 'tv_on_the_air_state.dart';

class TvOnTheAirBloc extends Bloc<TvOnTheAirEvent, TvOnTheAirState> {
  final GetTvOnTheAir _getTvOnTheAir;

  TvOnTheAirBloc(this._getTvOnTheAir) : super(TvOnTheAirEmpty()) {
    on<FetchTvOnTheAir>((event, emit) async {
      emit(TvOnTheAirLoading());
      final result = await _getTvOnTheAir.execute();

      result.fold(
        (failure) {
          emit(TvOnTheAirError(failure.message));
        },
        (data) {
          emit(TvOnTheAirHasData(data));
        },
      );
    });
  }
}
