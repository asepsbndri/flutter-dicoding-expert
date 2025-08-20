// movie_search_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';

import 'movies_search_event.dart';
import 'movies_search_state.dart';


class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc(this.searchMovies) : super(MovieSearchEmpty()) {
    on<OnMovieQueryChanged>((event, emit) async {
      final query = event.query;

      emit(MovieSearchLoading());

      final result = await searchMovies.execute(query);

      result.fold(
        (failure) => emit(MovieSearchError(failure.message)),
        (data) => emit(MovieSearchHasData(data)),
      );
    });
  }
}
