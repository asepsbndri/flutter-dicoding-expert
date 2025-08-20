import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_state.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularTvSeriesBloc extends Mock implements PopularTvSeriesBloc {}

class FakePopularTvSeriesEvent extends Fake implements PopularTvSeriesEvent {}

class FakePopularTvSeriesState extends Fake implements PopularTvSeriesState {}

void main() {
  late MockPopularTvSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularTvSeriesEvent());
    registerFallbackValue(FakePopularTvSeriesState());
  });

  setUp(() {
    mockBloc = MockPopularTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<PopularTvSeriesBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  // testWidgets('menampilkan CircularProgressIndicator ketika state Loading',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     PopularTvSeriesState.initial().copyWith(state: RequestState.Loading),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });

  // testWidgets('menampilkan ListView ketika state Loaded',
  //     (WidgetTester tester) async {
  //   final testTv = TvSeries(
  //      adult: false,
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
  //   );

  //   when(() => mockBloc.state).thenReturn(
  //     PopularTvSeriesState.initial().copyWith(
  //       state: RequestState.Loaded,
  //       tvSeries: [testTv],
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

  //   expect(find.byType(ListView), findsOneWidget);
  //   expect(find.text('Test Series'), findsOneWidget);
  // });

  // testWidgets('menampilkan error message ketika state Error',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     PopularTvSeriesState.initial().copyWith(
  //       state: RequestState.Error,
  //       message: 'Error terjadi',
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

  //   expect(find.byKey(const Key('error_message')), findsOneWidget);
  //   expect(find.text('Error terjadi'), findsOneWidget);
  // });

  // testWidgets('menampilkan No Data ketika state Empty',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(PopularTvSeriesState.initial());

  //   await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

  //   expect(find.text('No Data'), findsOneWidget);
  // });
}
