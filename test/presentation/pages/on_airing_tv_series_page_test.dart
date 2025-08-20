import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/on_airing_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/on_airing_tv_series_event.dart';
import 'package:ditonton/presentation/bloc/on_airing_tv_series_state.dart';
import 'package:ditonton/presentation/pages/on_airing_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnAiringTvSeriesBloc
    extends Mock implements OnAiringTvSeriesBloc {}

class FakeOnAiringTvSeriesState extends Fake
    implements OnAiringTvSeriesState {}

class FakeOnAiringTvSeriesEvent extends Fake
    implements OnAiringTvSeriesEvent {}

void main() {
  late MockOnAiringTvSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeOnAiringTvSeriesState());
    registerFallbackValue(FakeOnAiringTvSeriesEvent());
  });

  setUp(() {
    mockBloc = MockOnAiringTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<OnAiringTvSeriesBloc>.value(
        value: mockBloc,
        child: body,
      ),
    );
  }

  // testWidgets('menampilkan CircularProgressIndicator ketika state Loading',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     OnAiringTvSeriesState(state: RequestState.Loading),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const OnAiringTvSeriesPage()));

  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });

  // testWidgets('menampilkan ListView ketika state Loaded',
  //     (WidgetTester tester) async {
  //   final testTv = TvSeries
  //   (id: 1,
  //   adult: false,
  //    name: "Test TV",
  //     overview: "Overview",
  //     posterPath: "/path.jpg",
  //     firstAirDate: "2020-01-01",
  //     voteAverage: 8.0,
  //     voteCount: 100,
  //     genreIds: [1],
  //     backdropPath: "/backdrop.jpg",
  //     popularity: 50,
  //     originalName: "Test TV"
  //   );
  //   when(() => mockBloc.state).thenReturn(
  //     OnAiringTvSeriesState(
  //       state: RequestState.Loaded,
  //       tvSeries: [testTv],
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const OnAiringTvSeriesPage()));

  //   expect(find.byType(ListView), findsOneWidget);
  //   expect(find.text("Test TV"), findsOneWidget);
  // });

  // testWidgets('menampilkan error message ketika state Error',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     OnAiringTvSeriesState(
  //       state: RequestState.Error,
  //       message: "Error terjadi",
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget(const OnAiringTvSeriesPage()));

  //   expect(find.byKey(const Key('error_message')), findsOneWidget);
  //   expect(find.text("Error terjadi"), findsOneWidget);
  // });

  // testWidgets('menampilkan teks default ketika state Empty',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(OnAiringTvSeriesState());

  //   await tester.pumpWidget(makeTestableWidget(const OnAiringTvSeriesPage()));

  //   expect(find.text("Tidak ada data"), findsOneWidget);
  // });
}
