import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_state.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

void main() {
  late MockTopRatedMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMoviesBloc();
  });

  Widget makeTestable(Widget body) {
    return MaterialApp(
      home: BlocProvider<TopRatedMoviesBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  testWidgets('shows CircularProgressIndicator when loading',
      (tester) async {
    when(() => mockBloc.state)
        .thenReturn(const TopRatedMoviesState(state: RequestState.Loading));

    await tester.pumpWidget(makeTestable(const TopRatedMoviesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows ListView when loaded', (tester) async {
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

    when(() => mockBloc.state).thenReturn(
      TopRatedMoviesState(state: RequestState.Loaded, movies: [tMovie]),
    );

    await tester.pumpWidget(makeTestable(const TopRatedMoviesPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('shows error message when error', (tester) async {
    when(() => mockBloc.state).thenReturn(
      const TopRatedMoviesState(
        state: RequestState.Error,
        message: 'Error message',
      ),
    );

    await tester.pumpWidget(makeTestable(const TopRatedMoviesPage()));

    expect(find.text('Error message'), findsOneWidget);
  });

  testWidgets('shows No Data when state is empty', (tester) async {
    when(() => mockBloc.state).thenReturn(const TopRatedMoviesState());

    await tester.pumpWidget(makeTestable(const TopRatedMoviesPage()));

    expect(find.text('No Data'), findsOneWidget);
  });
}
