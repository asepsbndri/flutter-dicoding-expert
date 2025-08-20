import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_on_airing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';

import 'tv_series_list_event.dart';
import 'tv_series_list_state.dart';

class TvSeriesListBloc extends Bloc<TvSeriesListEvent, TvSeriesListState> {
  final GetOnAiringTvSeries getOnAiringTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesListBloc({
    required this.getOnAiringTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  }) : super(const TvSeriesListState()) {
    on<FetchOnAiringTvSeries>(_onFetchOnAiringTvSeries);
    on<FetchPopularTvSeries>(_onFetchPopularTvSeries);
    on<FetchTopRatedTvSeries>(_onFetchTopRatedTvSeries);
  }

  Future<void> _onFetchOnAiringTvSeries(
      FetchOnAiringTvSeries event, Emitter<TvSeriesListState> emit) async {
    emit(state.copyWith(onAiringState: RequestState.Loading));

    final result = await getOnAiringTvSeries.execute();
    result.fold(
      (failure) => emit(state.copyWith(
          onAiringState: RequestState.Error, message: failure.message)),
      (tvSeries) => emit(state.copyWith(
          onAiringState: RequestState.Loaded, onAiringTvSeries: tvSeries)),
    );
  }

  Future<void> _onFetchPopularTvSeries(
      FetchPopularTvSeries event, Emitter<TvSeriesListState> emit) async {
    emit(state.copyWith(popularTvSeriesState: RequestState.Loading));

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) => emit(state.copyWith(
          popularTvSeriesState: RequestState.Error, message: failure.message)),
      (tvSeries) => emit(state.copyWith(
          popularTvSeriesState: RequestState.Loaded, popularTvSeries: tvSeries)),
    );
  }

  Future<void> _onFetchTopRatedTvSeries(
      FetchTopRatedTvSeries event, Emitter<TvSeriesListState> emit) async {
    emit(state.copyWith(topRatedTvSeriesState: RequestState.Loading));

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) => emit(state.copyWith(
          topRatedTvSeriesState: RequestState.Error, message: failure.message)),
      (tvSeries) => emit(state.copyWith(
          topRatedTvSeriesState: RequestState.Loaded, topRatedTvSeries: tvSeries)),
    );
  }
}
