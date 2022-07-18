part of 'tv_on_the_air_bloc.dart';

abstract class TvOnTheAirState extends Equatable {
  const TvOnTheAirState();

  @override
  List<Object?> get props => [];
}

class TvOnTheAirEmpty extends TvOnTheAirState {}

class TvOnTheAirLoading extends TvOnTheAirState {}

class TvOnTheAirHasData extends TvOnTheAirState {
  final List<Tv> result;

  const TvOnTheAirHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TvOnTheAirError extends TvOnTheAirState {
  final String message;

  const TvOnTheAirError(this.message);

  @override
  List<Object?> get props => [message];
}
