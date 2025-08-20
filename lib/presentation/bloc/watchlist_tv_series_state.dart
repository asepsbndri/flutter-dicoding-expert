import 'package:equatable/equatable.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

class WatchlistTvState extends Equatable {
  final RequestState watchlistState;
  final List<TvSeries> watchlistTvSeries;
  final String message;

  const WatchlistTvState({
    this.watchlistState = RequestState.Empty,
    this.watchlistTvSeries = const [],
    this.message = '',
  });

  WatchlistTvState copyWith({
    RequestState? watchlistState,
    List<TvSeries>? watchlistTvSeries,
    String? message,
  }) {
    return WatchlistTvState(
      watchlistState: watchlistState ?? this.watchlistState,
      watchlistTvSeries: watchlistTvSeries ?? this.watchlistTvSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [watchlistState, watchlistTvSeries, message];
}
