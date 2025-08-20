import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchTvSeriesDetailEvent extends TvSeriesDetailEvent {
  final int id;
  const FetchTvSeriesDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddWatchlistTvSeriesEvent extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeries;
  const AddWatchlistTvSeriesEvent(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class RemoveWatchlistTvSeriesEvent extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeries;
  const RemoveWatchlistTvSeriesEvent(this.tvSeries);


  @override
  List<Object?> get props => [tvSeries];
}

class LoadWatchlistStatusTvSeriesEvent extends TvSeriesDetailEvent {
  final int id;
  const LoadWatchlistStatusTvSeriesEvent(this.id);

  @override
  List<Object?> get props => [id];
}
