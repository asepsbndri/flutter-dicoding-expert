import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';

import 'watchlist_movies_event.dart';
import 'watchlist_movies_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc(this.getWatchlistMovies) : super(const WatchlistMovieState()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(state.copyWith(watchlistState: RequestState.Loading));


      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          emit(state.copyWith(
            watchlistState: RequestState.Error,
            message: failure.message,
          ));
        },
        (movies) {
          emit(state.copyWith(
            watchlistState: RequestState.Loaded,
            watchlistMovies: movies,
          ));
        },
      );
    });
  }
}
