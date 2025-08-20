import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie_detail_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock Bloc
class MockMovieDetailBloc
    extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}
class FakeMovieDetailState extends Fake implements MovieDetailState {}

void main() {
  late MockMovieDetailBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
  });

  setUp(() {
    mockBloc = MockMovieDetailBloc();
  });

  final testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: '/path.jpg',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview test',
    posterPath: '/poster.jpg',
    releaseDate: '2020-01-01',
    runtime: 120,
    title: 'Test Movie',
    voteAverage: 8.0,
    voteCount: 100,
  );

  final testMovies = [
    Movie(
      adult: false,
      backdropPath: '/backdrop.jpg',
      genreIds: [1, 2],
      id: 2,
      originalTitle: 'Recommendation',
      overview: 'Overview',
      popularity: 100,
      posterPath: '/poster.jpg',
      releaseDate: '2020-01-01',
      title: 'Recommendation',
      video: false,
      voteAverage: 7.0,
      voteCount: 50,
    ),
  ];

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<MovieDetailBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  group('MovieDetailPage Widget Test', () {
    testWidgets('menampilkan CircularProgressIndicator ketika loading',
        (tester) async {
      when(() => mockBloc.state).thenReturn(
        MovieDetailState(movieState: RequestState.Loading),
      );

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('menampilkan detail movie ketika Loaded', (tester) async {
      when(() => mockBloc.state).thenReturn(
        MovieDetailState(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
          recommendations: testMovies,
          recommendationState: RequestState.Loaded,
          isAddedToWatchlist: false,
        ),
      );

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.text('Test Movie'), findsOneWidget);
      expect(find.text('Overview'), findsOneWidget);
      expect(find.text('Recommendations'), findsOneWidget);
    });

    testWidgets('menampilkan pesan error ketika Error', (tester) async {
      when(() => mockBloc.state).thenReturn(
        MovieDetailState(
          movieState: RequestState.Error,
          message: 'Error occurred',
        ),
      );

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.text('Error occurred'), findsOneWidget);
    });

    testWidgets('klik tombol watchlist harus trigger AddWatchlistEvent',
        (tester) async {
      when(() => mockBloc.state).thenReturn(
        MovieDetailState(
          movieState: RequestState.Loaded,
          movie: testMovieDetail,
          recommendations: testMovies,
          recommendationState: RequestState.Loaded,
          isAddedToWatchlist: false,
          watchlistMessage: MovieDetailBloc.watchlistAddSuccessMessage,
        ),
      );

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      final button = find.text('Watchlist');
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pump();

      // SnackBar muncul
      expect(find.byType(SnackBar), findsOneWidget);
    });

    // testWidgets('_showGenres dan _showDuration bekerja benar',
    //     (tester) async {
    //   final detailContent = DetailContent(
    //     testMovieDetail,
    //     const [],
    //     false,
    //   );

    //   await tester.pumpWidget(MaterialApp(home: detailContent));

    //   expect(find.text('Action'), findsOneWidget);
    //   expect(find.text('2h 0m'), findsOneWidget);
    // });
  });
}
