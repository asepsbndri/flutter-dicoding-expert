import 'package:equatable/equatable.dart';

abstract class OnAiringTvSeriesEvent extends Equatable {
  const OnAiringTvSeriesEvent();

  @override
  List<Object?> get props => [];
}

class FetchOnAiringTvSeries extends OnAiringTvSeriesEvent {}
