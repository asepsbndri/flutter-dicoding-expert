import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';


@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc bloc;
  late MockGetTopRatedMovies mockUsecase;

  setUp(() {
    mockUsecase = MockGetTopRatedMovies();
    bloc = TopRatedMoviesBloc(mockUsecase);
  });

  final tMovie = Movie(
    id: 1,
    title: 'Test',
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: '2020-01-01',
    voteAverage: 8.0,
    voteCount: 100,
    genreIds: [1],
    backdropPath: '/backdrop.jpg',
    popularity: 50,
    adult: false,
    video: false,
    originalTitle: 'Test',
  );

  final tMovies = [tMovie];

  test('initial state should be empty', () {
    expect(bloc.state, const TopRatedMoviesState());
  });

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [Loading, Loaded] when FetchTopRatedMovies succeeds',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [
      const TopRatedMoviesState(state: RequestState.Loading),
      TopRatedMoviesState(state: RequestState.Loaded, movies: tMovies),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );

  blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
    'emits [Loading, Error] when FetchTopRatedMovies fails',
    build: () {
      when(mockUsecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () => [
      const TopRatedMoviesState(state: RequestState.Loading),
      const TopRatedMoviesState(
        state: RequestState.Error,
        message: 'Server Error',
      ),
    ],
    verify: (bloc) {
      verify(mockUsecase.execute());
    },
  );
}
