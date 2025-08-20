import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_state.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_state.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class MockWatchlistTvBloc
    extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

void main() {
  late MockWatchlistMovieBloc mockMovieBloc;
  late MockWatchlistTvBloc mockTvBloc;

  setUp(() {
    mockMovieBloc = MockWatchlistMovieBloc();
    mockTvBloc = MockWatchlistTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMovieBloc>.value(value: mockMovieBloc),
        BlocProvider<WatchlistTvBloc>.value(value: mockTvBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tMovie = Movie(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/poster.jpg',
    releaseDate: '2020-01-01',
    title: 'Test Movie',
    video: false,
    voteAverage: 8.0,
    voteCount: 100,
  );

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: '/backdrop.jpg',
    firstAirDate: '2021-01-01',
    genreIds: [1, 2],
    id: 2,
    name: 'Test TV',
    originalName: 'Original TV',
    overview: 'Overview tv',
    popularity: 2.0,
    posterPath: '/poster_tv.jpg',
    voteAverage: 7.5,
    voteCount: 50,
  );

  testWidgets('Menampilkan loading indicator saat loading',
      (WidgetTester tester) async {
    when(() => mockMovieBloc.state).thenReturn(
      WatchlistMovieState(
        watchlistState: RequestState.Loading,
        watchlistMovies: const [],
        message: '',
      ),
    );
    when(() => mockTvBloc.state).thenReturn(
      WatchlistTvState(
        watchlistState: RequestState.Loading,
        watchlistTvSeries: const [],
        message: '',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Menampilkan data movie dan tv ketika loaded',
      (WidgetTester tester) async {
    when(() => mockMovieBloc.state).thenReturn(
      WatchlistMovieState(
        watchlistState: RequestState.Loaded,
        watchlistMovies: [tMovie],
        message: '',
      ),
    );
    when(() => mockTvBloc.state).thenReturn(
      WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: [tTvSeries],
        message: '',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(find.text('Test Movie'), findsOneWidget);
    expect(find.text('Test TV'), findsOneWidget);
  });

  testWidgets('Menampilkan pesan error saat error',
      (WidgetTester tester) async {
    when(() => mockMovieBloc.state).thenReturn(
      WatchlistMovieState(
        watchlistState: RequestState.Error,
        watchlistMovies: const [],
        message: 'Error Movie',
      ),
    );
    when(() => mockTvBloc.state).thenReturn(
      WatchlistTvState(
        watchlistState: RequestState.Error,
        watchlistTvSeries: const [],
        message: 'Error TV',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
    expect(find.text('Error Movie'), findsOneWidget);
  });

  testWidgets('Menampilkan pesan kosong saat watchlist kosong',
      (WidgetTester tester) async {
    when(() => mockMovieBloc.state).thenReturn(
      WatchlistMovieState(
        watchlistState: RequestState.Loaded,
        watchlistMovies: const [],
        message: '',
      ),
    );
    when(() => mockTvBloc.state).thenReturn(
      WatchlistTvState(
        watchlistState: RequestState.Loaded,
        watchlistTvSeries: const [],
        message: '',
      ),
    );

    await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(find.text('Watchlist masih kosong'), findsOneWidget);
  });
}
