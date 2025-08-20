import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';

import 'tv_series_detail_event.dart';
import 'tv_series_detail_state.dart';

class TvSeriesDetailBloc extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetWatchlistTvSeriesStatus getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvSeriesDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const TvSeriesDetailState()) {
    // Fetch detail
    on<FetchTvSeriesDetailEvent>((event, emit) async {
      emit(state.copyWith(tvSeriesState: RequestState.Loading));

      final detailResult = await getTvSeriesDetail.execute(event.id);
      final recommendationResult = await getTvSeriesRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(state.copyWith(
            tvSeriesState: RequestState.Error,
            message: failure.message,
          ));
        },
        (tvSeriesData) {
          emit(state.copyWith(
            tvSeries: tvSeriesData,
            tvSeriesState: RequestState.Loaded,
            recommendationState: RequestState.Loading,
          ));

          recommendationResult.fold(
            (failure) {
              emit(state.copyWith(
                recommendationState: RequestState.Error,
                message: failure.message,
              ));
            },
            (recommendations) {
              emit(state.copyWith(
                recommendationState: RequestState.Loaded,
                recommendations: recommendations,
              ));
            },
          );
        },
      );
    });

    // Add watchlist
    on<AddWatchlistTvSeriesEvent>((event, emit) async {
      final result = await saveWatchlist.execute(event.tvSeries);
      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(
            watchlistMessage: successMessage,
            isAddedToWatchlist: true,
          ));
        },
      );
    });

    // Remove watchlist
    on<RemoveWatchlistTvSeriesEvent>((event, emit) async {
      final result = await removeWatchlist.execute(event.tvSeries);
      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(
            watchlistMessage: successMessage,
            isAddedToWatchlist: false,
          ));
        },
      );
    });


    // Load watchlist status
    on<LoadWatchlistStatusTvSeriesEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
