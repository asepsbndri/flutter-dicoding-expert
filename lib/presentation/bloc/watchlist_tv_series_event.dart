import 'package:equatable/equatable.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object?> get props => [];
}

class FetchWatchlistTvSeries extends WatchlistTvEvent {}
