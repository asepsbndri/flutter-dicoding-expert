import 'package:equatable/equatable.dart';

abstract class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object?> get props => [];
}

class OnTvSeriesQueryChanged extends TvSeriesSearchEvent {
  final String query;

  const OnTvSeriesQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}
