import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_event.dart';
import 'package:ditonton/presentation/bloc/popular_movies_state.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularMoviesBloc extends Mock implements PopularMoviesBloc {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

class FakePopularMoviesEvent extends Fake implements PopularMoviesEvent {}

void main() {
  late MockPopularMoviesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularMoviesState());
    registerFallbackValue(FakePopularMoviesEvent());
  });

  setUp(() {
    mockBloc = MockPopularMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<PopularMoviesBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  // testWidgets('menampilkan CircularProgressIndicator ketika state Loading',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     PopularMoviesState(state: RequestState.Loading),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });

  // testWidgets('menampilkan ListView ketika state Loaded',
  //     (WidgetTester tester) async {
  //   final testMovie = Movie.watchlist(
  //     id: 1,
  //     overview: "overview",
  //     posterPath: "posterPath",
  //     title: "Test Movie",
  //   );

  //   when(() => mockBloc.state).thenReturn(
  //     PopularMoviesState(
  //       state: RequestState.Loaded,
  //       movies: [testMovie],
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

  //   expect(find.byType(ListView), findsOneWidget);
  //   expect(find.text("Test Movie"), findsOneWidget);
  // });

  // testWidgets('menampilkan error message ketika state Error',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     PopularMoviesState(
  //       state: RequestState.Error,
  //       message: "Error terjadi",
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

  //   expect(find.byKey(const Key('error_message')), findsOneWidget);
  //   expect(find.text("Error terjadi"), findsOneWidget);
  // });

  // testWidgets('menampilkan Container kosong ketika state Empty',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(PopularMoviesState());

  //   await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

  //   expect(find.byType(Container), findsOneWidget);
  // });
}
