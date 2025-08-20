import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_on_airing_tv_series.dart';

import 'on_airing_tv_series_event.dart';
import 'on_airing_tv_series_state.dart';

class OnAiringTvSeriesBloc
    extends Bloc<OnAiringTvSeriesEvent, OnAiringTvSeriesState> {
  final GetOnAiringTvSeries getOnAiringTvSeries;

  OnAiringTvSeriesBloc(this.getOnAiringTvSeries)
      : super(const OnAiringTvSeriesState()) {
    on<FetchOnAiringTvSeries>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));

      final result = await getOnAiringTvSeries.execute();

      result.fold(
        (failure) {
          emit(state.copyWith(
            state: RequestState.Error,
            message: failure.message,
          ));
        },
        (tvSeriesData) {
          emit(state.copyWith(
            state: RequestState.Loaded,
            tvSeries: tvSeriesData,
          ));
        },
      );
    });
  }
}
