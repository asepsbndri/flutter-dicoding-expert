import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movies.dart';
import '../../domain/usecases/get_watchlist_movies_status.dart';
import '../../domain/usecases/remove_watchlist_movies.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/common/state_enum.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlistMovies saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const MovieDetailState()) {
    on<FetchMovieDetailEvent>(_onFetchMovieDetail);
    on<LoadWatchlistStatusEvent>(_onLoadWatchlistStatus);
    on<AddWatchlistEvent>(_onAddWatchlist);
    on<RemoveWatchlistEvent>(_onRemoveWatchlist);
  }

  Future<void> _onFetchMovieDetail(
      FetchMovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    emit(state.copyWith(movieState: RequestState.Loading));

    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult = await getMovieRecommendations.execute(event.id);

    detailResult.fold(
      (failure) {
        emit(state.copyWith(
          movieState: RequestState.Error,
          message: failure.message,
        ));
      },
      (movie) {
        emit(state.copyWith(
          movieState: RequestState.Loaded,
          movie: movie,
        ));
        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(
              recommendationState: RequestState.Error,
              message: failure.message,
            ));
          },
          (movies) {
            emit(state.copyWith(
              recommendationState: RequestState.Loaded,
              recommendations: movies,
            ));
          },
        );
      },
    );
  }

  Future<void> _onLoadWatchlistStatus(
      LoadWatchlistStatusEvent event, Emitter<MovieDetailState> emit) async {
    final result = await getWatchListStatus.execute(event.id);
    emit(state.copyWith(isAddedToWatchlist: result));
  }

  Future<void> _onAddWatchlist(
      AddWatchlistEvent event, Emitter<MovieDetailState> emit) async {
    final result = await saveWatchlist.execute(event.movie);
    result.fold(
      (failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) {
        emit(state.copyWith(
          isAddedToWatchlist: true,
          watchlistMessage: watchlistAddSuccessMessage,
        ));
      },
    );
  }

  Future<void> _onRemoveWatchlist(
      RemoveWatchlistEvent event, Emitter<MovieDetailState> emit) async {
    final result = await removeWatchlist.execute(event.movie);
    result.fold(
      (failure) {
        emit(state.copyWith(watchlistMessage: failure.message));
      },
      (successMessage) {
        emit(state.copyWith(
          isAddedToWatchlist: false,
          watchlistMessage: watchlistRemoveSuccessMessage,
        ));
      },
    );
  }
}
