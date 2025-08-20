import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';


@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlistMovies,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlistMovies mockSaveWatchlistMovies;
  late MockRemoveWatchlist mockRemoveWatchlist;

  const tId = 1;

  const tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: '2020-05-05',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovies = <Movie>[
    Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: '2020-05-05',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    )
  ];

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlistMovies = MockSaveWatchlistMovies();
    mockRemoveWatchlist = MockRemoveWatchlist();

    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlistMovies,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  group('FetchMovieDetailEvent', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, Loaded + Recommendations Loaded] when success',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailEvent(tId)),
      expect: () => [
        const MovieDetailState(movieState: RequestState.Loading),
        MovieDetailState(
          movieState: RequestState.Loaded,
          movie: tMovieDetail,
        ),
        MovieDetailState(
          movieState: RequestState.Loaded,
          movie: tMovieDetail,
          recommendationState: RequestState.Loaded,
          recommendations: tMovies,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Loading, Error] when getMovieDetail fails',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailEvent(tId)),
      expect: () => [
        const MovieDetailState(movieState: RequestState.Loading),
        const MovieDetailState(
          movieState: RequestState.Error,
          message: 'Failed',
        ),
      ],
    );
  });

  group('LoadWatchlistStatusEvent', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits state with isAddedToWatchlist true',
      build: () {
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatusEvent(tId)),
      expect: () => [
        const MovieDetailState(isAddedToWatchlist: true),
      ],
    );
  });

  group('AddWatchlistEvent', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits success message and isAddedToWatchlist true',
      build: () {
        when(mockSaveWatchlistMovies.execute(tMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return bloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistEvent(tMovieDetail)),
      expect: () => [
        const MovieDetailState(
          isAddedToWatchlist: true,
          watchlistMessage: MovieDetailBloc.watchlistAddSuccessMessage,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits failure message when add fails',
      build: () {
        when(mockSaveWatchlistMovies.execute(tMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistEvent(tMovieDetail)),
      expect: () => [
        const MovieDetailState(watchlistMessage: 'Failed'),
      ],
    );
  });

  group('RemoveWatchlistEvent', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits success message and isAddedToWatchlist false',
      build: () {
        when(mockRemoveWatchlist.execute(tMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return bloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistEvent(tMovieDetail)),
      expect: () => [
        const MovieDetailState(
          isAddedToWatchlist: false,
          watchlistMessage: MovieDetailBloc.watchlistRemoveSuccessMessage,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits failure message when remove fails',
      build: () {
        when(mockRemoveWatchlist.execute(tMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        return bloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistEvent(tMovieDetail)),
      expect: () => [
        const MovieDetailState(watchlistMessage: 'Failed'),
      ],
    );
  });
}
