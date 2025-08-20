import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ditonton/presentation/bloc/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie_list_state.dart';

import 'movie_list_bloc_test.mocks.dart';


@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
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

  group('Now Playing Movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        const MovieListState(nowPlayingState: RequestState.Loading),
        MovieListState(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMovies()),
      expect: () => [
        const MovieListState(nowPlayingState: RequestState.Loading),
        const MovieListState(
          nowPlayingState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Popular Movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        const MovieListState(popularMoviesState: RequestState.Loading),
        MovieListState(
          popularMoviesState: RequestState.Loaded,
          popularMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovies()),
      expect: () => [
        const MovieListState(popularMoviesState: RequestState.Loading),
        const MovieListState(
          popularMoviesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });

  group('Top Rated Movies', () {
    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        const MovieListState(topRatedMoviesState: RequestState.Loading),
        MovieListState(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: tMovieList,
        ),
      ],
    );

    blocTest<MovieListBloc, MovieListState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovies()),
      expect: () => [
        const MovieListState(topRatedMoviesState: RequestState.Loading),
        const MovieListState(
          topRatedMoviesState: RequestState.Error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}
