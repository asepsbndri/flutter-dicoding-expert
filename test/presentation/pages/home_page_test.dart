import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie_list_state.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_list_state.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockMovieListBloc extends MockBloc<MovieListEvent, MovieListState>
    implements MovieListBloc {}

class MockTvSeriesListBloc
    extends MockBloc<TvSeriesListEvent, TvSeriesListState>
    implements TvSeriesListBloc {}

void main() {
  late MockMovieListBloc mockMovieListBloc;
  late MockTvSeriesListBloc mockTvSeriesListBloc;

  setUp(() {
    mockMovieListBloc = MockMovieListBloc();
    mockTvSeriesListBloc = MockTvSeriesListBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>.value(value: mockMovieListBloc),
        BlocProvider<TvSeriesListBloc>.value(value: mockTvSeriesListBloc),
      ],
      child: MaterialApp(home: body),
    );
  }

  testWidgets('menampilkan CircularProgressIndicator saat loading',
      (tester) async {
    // arrange Movie Bloc
    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState().copyWith(
        nowPlayingState: RequestState.Loading,
        popularMoviesState: RequestState.Loading,
        topRatedMoviesState: RequestState.Loading,
      ),
    );

    // arrange TV Bloc
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState().copyWith(
        onAiringState: RequestState.Loading,
        popularTvSeriesState: RequestState.Loading,
        topRatedTvSeriesState: RequestState.Loading,
      ),
    );

    // act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));

    // assert -> harus ada CircularProgressIndicator
    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('menampilkan list movie & tv series saat loaded', (tester) async {
    final testMovie = Movie(
      adult: false,
      backdropPath: '/backdrop.jpg',
      genreIds: [1, 2],
      id: 1,
      originalTitle: 'Test Movie',
      overview: 'overview',
      popularity: 1.0,
      posterPath: '/poster.jpg',
      releaseDate: '2020-01-01',
      title: 'Test Movie',
      video: false,
      voteAverage: 8.0,
      voteCount: 100,
    );

    final testTv = TvSeries(
      adult: false,
      backdropPath: '/backdrop.jpg',
      genreIds: [1, 2],
      id: 1,
      name: 'Test TV',
      originalName: 'Test TV',
      overview: 'overview',
      popularity: 1.0,
      posterPath: '/poster.jpg',
      firstAirDate: '2020-01-01',
      voteAverage: 8.0,
      voteCount: 100,
    );

    // arrange Movie Bloc
    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState().copyWith(
        nowPlayingState: RequestState.Loaded,
        nowPlayingMovies: [testMovie],
        popularMoviesState: RequestState.Loaded,
        popularMovies: [testMovie],
        topRatedMoviesState: RequestState.Loaded,
        topRatedMovies: [testMovie],
      ),
    );

    // arrange TV Bloc
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState().copyWith(
        onAiringState: RequestState.Loaded,
        onAiringTvSeries: [testTv],
        popularTvSeriesState: RequestState.Loaded,
        popularTvSeries: [testTv],
        topRatedTvSeriesState: RequestState.Loaded,
        topRatedTvSeries: [testTv],
      ),
    );

    // act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));

    // assert -> harus ada judul dan poster
    expect(find.text('Now Airing TV Series'), findsOneWidget);
    expect(find.text('Popular Movies'), findsOneWidget);
    expect(find.text('Test Movie'), findsNothing); // judul movie gak ditampilkan
    expect(find.byType(CachedNetworkImage), findsWidgets);
  });

  testWidgets('menampilkan text Failed saat error', (tester) async {
    // arrange Movie Bloc
    when(() => mockMovieListBloc.state).thenReturn(
      MovieListState().copyWith(
        nowPlayingState: RequestState.Error,
      ),
    );

    // arrange TV Bloc
    when(() => mockTvSeriesListBloc.state).thenReturn(
      TvSeriesListState().copyWith(
        onAiringState: RequestState.Error,
      ),
    );

    // act
    await tester.pumpWidget(makeTestableWidget(const HomePage()));

    // assert
    expect(find.text('Failed'), findsWidgets);
  });
}
