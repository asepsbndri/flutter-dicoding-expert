import 'package:equatable/equatable.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';

class TvSeriesListState extends Equatable {
  final List<TvSeries> onAiringTvSeries;
  final RequestState onAiringState;

  final List<TvSeries> popularTvSeries;
  final RequestState popularTvSeriesState;

  final List<TvSeries> topRatedTvSeries;
  final RequestState topRatedTvSeriesState;

  final String message;

  const TvSeriesListState({
    this.onAiringTvSeries = const [],
    this.onAiringState = RequestState.Empty,
    this.popularTvSeries = const [],
    this.popularTvSeriesState = RequestState.Empty,
    this.topRatedTvSeries = const [],
    this.topRatedTvSeriesState = RequestState.Empty,
    this.message = '',
  });

  TvSeriesListState copyWith({
    List<TvSeries>? onAiringTvSeries,
    RequestState? onAiringState,
    List<TvSeries>? popularTvSeries,
    RequestState? popularTvSeriesState,
    List<TvSeries>? topRatedTvSeries,
    RequestState? topRatedTvSeriesState,
    String? message,
  }) {
    return TvSeriesListState(
      onAiringTvSeries: onAiringTvSeries ?? this.onAiringTvSeries,
      onAiringState: onAiringState ?? this.onAiringState,
      popularTvSeries: popularTvSeries ?? this.popularTvSeries,
      popularTvSeriesState: popularTvSeriesState ?? this.popularTvSeriesState,
      topRatedTvSeries: topRatedTvSeries ?? this.topRatedTvSeries,
      topRatedTvSeriesState: topRatedTvSeriesState ?? this.topRatedTvSeriesState,
      message: message ?? this.message,
    );
  }
  

  @override
  List<Object?> get props => [
        onAiringTvSeries,
        onAiringState,
        popularTvSeries,
        popularTvSeriesState,
        topRatedTvSeries,
        topRatedTvSeriesState,
        message,
      ];
}
