import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_state.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopRatedTvSeriesBloc extends Mock implements TopRatedTvSeriesBloc {}

class FakeTopRatedTvSeriesEvent extends Fake implements TopRatedTvSeriesEvent {}

class FakeTopRatedTvSeriesState extends Fake implements TopRatedTvSeriesState {}

void main() {
  late MockTopRatedTvSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTvSeriesEvent());
    registerFallbackValue(FakeTopRatedTvSeriesState());
  });

  setUp(() {
    mockBloc = MockTopRatedTvSeriesBloc();
  });

  Widget makeTestableWidget() {
    return BlocProvider<TopRatedTvSeriesBloc>.value(
      value: mockBloc,
      child: const MaterialApp(
        home: TopRatedTvSeriesPage(),
      ),
    );
  }

  // testWidgets('menampilkan loading indicator ketika state Loading',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     TopRatedTvSeriesState(state: RequestState.Loading),
  //   );

  //   await tester.pumpWidget(makeTestableWidget());

  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });

  // testWidgets('menampilkan ListView ketika state Loaded',
  //     (WidgetTester tester) async {
  //   final tv = TvSeries(
  //     adult: false,
  //     id: 1,
  //     name: 'Breaking Bad',
  //     overview: 'Overview',
  //     posterPath: '/poster.jpg',
  //     backdropPath: '/backdrop.jpg',
  //     voteAverage: 9.0,
  //     voteCount: 100,
  //     firstAirDate: '2008-01-01',
  //     genreIds: const [1, 2],
  //     originalName: 'Breaking Bad',
  //     popularity: 99.9,
  //   );

  //   when(() => mockBloc.state).thenReturn(
  //     TopRatedTvSeriesState(
  //       state: RequestState.Loaded,
  //       tvSeries: [tv],
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget());

  //   expect(find.byType(ListView), findsOneWidget);
  //   expect(find.text('Test TV'), findsOneWidget);
  // });

  // testWidgets('menampilkan error message ketika state Error',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     TopRatedTvSeriesState(
  //       state: RequestState.Error,
  //       message: 'Error Message',
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget());

  //   expect(find.byKey(const Key('error_message')), findsOneWidget);
  //   expect(find.text('Error Message'), findsOneWidget);
  // });

  // testWidgets('menampilkan teks default ketika state Empty',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     TopRatedTvSeriesState(state: RequestState.Empty),
  //   );

  //   await tester.pumpWidget(makeTestableWidget());

  //   expect(find.text('Tidak ada data'), findsOneWidget);
  // });
}
