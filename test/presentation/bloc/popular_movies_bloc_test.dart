import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_event.dart';
import 'package:ditonton/presentation/bloc/popular_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_bloc_test.mocks.dart';


@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = PopularMoviesBloc(mockGetPopularMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: '2020-01-01',
    title: 'Title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('initial state harus PopularMoviesState default', () {
    expect(bloc.state, const PopularMoviesState());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'emit [Loading, Loaded] ketika data popular movies berhasil diambil',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      const PopularMoviesState(state: RequestState.Loading),
      PopularMoviesState(
        state: RequestState.Loaded,
        movies: tMovieList,
      ),
    ],
    verify: (_) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'emit [Loading, Error] ketika gagal ambil data popular movies',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      const PopularMoviesState(state: RequestState.Loading),
      const PopularMoviesState(
        state: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
    verify: (_) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
