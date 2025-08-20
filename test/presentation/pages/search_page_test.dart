import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/movies_search_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_search_state.dart';
import 'package:ditonton/presentation/bloc/movies_search_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_state.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_event.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieSearchBloc extends Mock implements MovieSearchBloc {}
class MockTvSeriesSearchBloc extends Mock implements TvSeriesSearchBloc {}

class FakeMovieSearchEvent extends Fake implements MovieSearchEvent {}
class FakeMovieSearchState extends Fake implements MovieSearchState {}
class FakeTvSeriesSearchEvent extends Fake implements TvSeriesSearchEvent {}
class FakeTvSeriesSearchState extends Fake implements TvSeriesSearchState {}

void main() {
  late MockMovieSearchBloc mockMovieBloc;
  late MockTvSeriesSearchBloc mockTvBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieSearchEvent());
    registerFallbackValue(FakeMovieSearchState());
    registerFallbackValue(FakeTvSeriesSearchEvent());
    registerFallbackValue(FakeTvSeriesSearchState());
  });

  setUp(() {
    mockMovieBloc = MockMovieSearchBloc();
    mockTvBloc = MockTvSeriesSearchBloc();
  });

  Widget makeTestableWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieSearchBloc>.value(value: mockMovieBloc),
        BlocProvider<TvSeriesSearchBloc>.value(value: mockTvBloc),
      ],
      child: const MaterialApp(
        home: SearchPage(),
      ),
    );
  }

  // group('SearchPage - Movies Tab', () {
  //   testWidgets('menampilkan loading ketika MovieSearchLoading',
  //       (WidgetTester tester) async {
  //     when(() => mockMovieBloc.state).thenReturn(MovieSearchLoading());
  //     when(() => mockTvBloc.state).thenReturn(TvSeriesSearchEmpty());

  //     await tester.pumpWidget(makeTestableWidget());

  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //   });

  //   testWidgets('menampilkan ListView ketika MovieSearchHasData',
  //       (WidgetTester tester) async {
  //     final movie = Movie(
  //       adult: false,
  //       releaseDate: '2021-01-01',
  //       genreIds: const [1, 2],
  //       originalTitle: 'Test Movie',
  //       video: false,
  //       voteAverage: 8.0,
  //       voteCount: 100,
  //       backdropPath: '/backdrop.jpg',
  //       popularity: 50.0,
  //       id: 1,
  //       title: 'Test Movie',
  //       overview: 'Overview',
  //       posterPath: 'path',
  //     );

  //     when(() => mockMovieBloc.state).thenReturn(MovieSearchHasData([movie]));
  //     when(() => mockTvBloc.state).thenReturn(TvSeriesSearchEmpty());

  //     await tester.pumpWidget(makeTestableWidget());

  //     expect(find.byType(ListView), findsOneWidget);
  //     expect(find.text('Test Movie'), findsOneWidget);
  //   });

  //   testWidgets('menampilkan error message ketika MovieSearchError',
  //       (WidgetTester tester) async {
  //     when(() => mockMovieBloc.state).thenReturn(MovieSearchError('Error Movie'));
  //     when(() => mockTvBloc.state).thenReturn(TvSeriesSearchEmpty());

  //     await tester.pumpWidget(makeTestableWidget());

  //     expect(find.text('Error Movie'), findsOneWidget);
  //   });

  //   testWidgets('menampilkan text default ketika MovieSearchEmpty',
  //       (WidgetTester tester) async {
  //     when(() => mockMovieBloc.state).thenReturn(MovieSearchEmpty());
  //     when(() => mockTvBloc.state).thenReturn(TvSeriesSearchEmpty());

  //     await tester.pumpWidget(makeTestableWidget());

  //     expect(find.text('Cari Film'), findsOneWidget);
  //   });
  // });

  // group('SearchPage - TV Series Tab', () {
  //   testWidgets('menampilkan loading ketika TvSeriesSearchLoading',
  //       (WidgetTester tester) async {
  //     when(() => mockMovieBloc.state).thenReturn(MovieSearchEmpty());
  //     when(() => mockTvBloc.state).thenReturn(TvSeriesSearchLoading());

  //     await tester.pumpWidget(makeTestableWidget());

  //     // Pindah ke tab ke-2 (TV Series)
  //     await tester.tap(find.text('TV Series'));
  //     await tester.pump();

  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //   });

  //   testWidgets('menampilkan ListView ketika TvSeriesSearchHasData',
  //       (WidgetTester tester) async {
  //     final tv = TvSeries(
  //   adult: false,
  //   id: 1,
  //   name: 'Breaking Bad',
  //   overview: 'Overview',
  //   posterPath: '/poster.jpg',
  //   backdropPath: '/backdrop.jpg',
  //   voteAverage: 9.0,
  //   voteCount: 100,
  //   firstAirDate: '2008-01-01',
  //   genreIds: const [1, 2],
  //   originalName: 'Breaking Bad',
  //   popularity: 99.9,
  // );

  //     when(() => mockMovieBloc.state).thenReturn(MovieSearchEmpty());
  //     when(() => mockTvBloc.state).thenReturn(TvSeriesSearchHasData([tv]));

  //     await tester.pumpWidget(makeTestableWidget());

  //     await tester.tap(find.text('TV Series'));
  //     await tester.pump();

  //     expect(find.byType(ListView), findsOneWidget);
  //     expect(find.text('Test Series'), findsOneWidget);
  //   });

  //   testWidgets('menampilkan error message ketika TvSeriesSearchError',
  //       (WidgetTester tester) async {
  //     when(() => mockMovieBloc.state).thenReturn(MovieSearchEmpty());
  //     when(() => mockTvBloc.state).thenReturn(TvSeriesSearchError('Error TV'));

  //     await tester.pumpWidget(makeTestableWidget());

  //     await tester.tap(find.text('TV Series'));
  //     await tester.pump();

  //     expect(find.text('Error TV'), findsOneWidget);
  //   });

  //   testWidgets('menampilkan text default ketika TvSeriesSearchEmpty',
  //       (WidgetTester tester) async {
  //     when(() => mockMovieBloc.state).thenReturn(MovieSearchEmpty());
  //     when(() => mockTvBloc.state).thenReturn(TvSeriesSearchEmpty());

  //     await tester.pumpWidget(makeTestableWidget());

  //     await tester.tap(find.text('TV Series'));
  //     await tester.pump();

  //     expect(find.text('Cari TV Series'), findsOneWidget);
  //   });
  // });
}
