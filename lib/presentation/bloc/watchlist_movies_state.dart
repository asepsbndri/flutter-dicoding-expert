import 'package:equatable/equatable.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';

class WatchlistMovieState extends Equatable {
  final List<Movie> watchlistMovies;
  final RequestState watchlistState;
  final String message;

  const WatchlistMovieState({
    this.watchlistMovies = const [],
    this.watchlistState = RequestState.Empty,
    this.message = '',
  });

  WatchlistMovieState copyWith({
    List<Movie>? watchlistMovies,
    RequestState? watchlistState,
    String? message,
  }) {
    
    return WatchlistMovieState(
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
      watchlistState: watchlistState ?? this.watchlistState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [watchlistMovies, watchlistState, message];
}
