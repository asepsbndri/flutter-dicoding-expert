import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovieDetailEvent extends MovieDetailEvent {
  final int id;
  const FetchMovieDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}


class AddWatchlistEvent extends MovieDetailEvent {
  final dynamic movie; 
  const AddWatchlistEvent(this.movie);

  @override
  List<Object?> get props => [movie];
}

class RemoveWatchlistEvent extends MovieDetailEvent {
  final dynamic movie;
  const RemoveWatchlistEvent(this.movie);

  @override
  List<Object?> get props => [movie];
}

class LoadWatchlistStatusEvent extends MovieDetailEvent {
  final int id;
  const LoadWatchlistStatusEvent(this.id);

  @override
  List<Object?> get props => [id];
}
