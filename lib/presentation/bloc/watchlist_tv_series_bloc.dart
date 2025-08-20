import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';

import 'watchlist_tv_series_event.dart';
import 'watchlist_tv_series_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvBloc(this.getWatchlistTvSeries) : super(const WatchlistTvState()) {
    on<FetchWatchlistTvSeries>((event, emit) async {
      emit(state.copyWith(watchlistState: RequestState.Loading));

      final result = await getWatchlistTvSeries.execute();


      result.fold(
        (failure) {
          emit(state.copyWith(
            watchlistState: RequestState.Error,
            message: failure.message,
          ));
        },
        (tvSeriesData) {
          emit(state.copyWith(
            watchlistState: RequestState.Loaded,
            watchlistTvSeries: tvSeriesData,
          ));
        },
      );
    });
  }
}
