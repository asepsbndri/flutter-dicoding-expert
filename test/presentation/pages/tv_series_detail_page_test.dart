import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_state.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class FakeTvSeriesDetailEvent extends Fake implements TvSeriesDetailEvent {}
class FakeTvSeriesDetailState extends Fake implements TvSeriesDetailState {}

void main() {
  late MockTvSeriesDetailBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvSeriesDetailEvent());
    registerFallbackValue(FakeTvSeriesDetailState());
  });

  setUp(() {
    mockBloc = MockTvSeriesDetailBloc();
  });

  Widget makeTestableWidget() {
    return BlocProvider<TvSeriesDetailBloc>.value(
      value: mockBloc,
      child: const MaterialApp(
        home: TvSeriesDetailPage(id: 1),
      ),
    );
  }

  final tTvSeriesDetail = TvSeriesDetail(
    id: 1,
    name: 'Test TV',
    overview: 'Overview test',
    posterPath: '/test.jpg',
    backdropPath: '/backdrop.jpg',
    voteAverage: 8.0,
    voteCount: 100,
    genres: [
      Genre(id: 1, name: 'Drama'),
      Genre(id: 2, name: 'Action'),
    ],
    firstAirDate: '2021-01-01',
    numberOfSeasons: 2,
    numberOfEpisodes: 20,
  );

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: '/backdrop.jpg',
    firstAirDate: '2021-01-01',
    genreIds: [1, 2],
    voteAverage: 8.0,
    originalName: "Test TV",
    voteCount: 100,
    popularity: 50.0,
    id: 1,
    name: 'Test TV',
    overview: 'Overview test',
    posterPath: '/test.jpg',
  );

  testWidgets('menampilkan loading ketika state Loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      TvSeriesDetailState(tvSeriesState: RequestState.Loading),
    );

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // testWidgets('menampilkan detail tv ketika state Loaded',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     TvSeriesDetailState(
  //       tvSeriesState: RequestState.Loaded,
  //       tvSeries: tTvSeriesDetail,
  //       isAddedToWatchlist: false,
  //       recommendations: [tTvSeries],
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget());

  //   expect(find.text('Test TV'), findsOneWidget);
  //   expect(find.text('Overview test'), findsOneWidget);
  //   expect(find.text('Drama'), findsOneWidget);
  //   expect(find.byType(FilledButton), findsOneWidget);
  // });

  testWidgets('menampilkan error ketika state Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      TvSeriesDetailState(
        tvSeriesState: RequestState.Error,
        message: 'Error Message',
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Error Message'), findsOneWidget);
  });

  testWidgets('menampilkan rekomendasi ketika recommendation Loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      TvSeriesDetailState(
        tvSeriesState: RequestState.Loaded,
        tvSeries: tTvSeriesDetail,
        recommendationState: RequestState.Loaded,
        recommendations: [tTvSeries],
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('menampilkan error rekomendasi ketika recommendation Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(
      TvSeriesDetailState(
        tvSeriesState: RequestState.Loaded,
        tvSeries: tTvSeriesDetail,
        recommendationState: RequestState.Error,
        message: 'Recommendation Error',
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Recommendation Error'), findsOneWidget);
  });

  // testWidgets('menampilkan CircularProgressIndicator ketika recommendation Loading',
  //     (WidgetTester tester) async {
  //   when(() => mockBloc.state).thenReturn(
  //     TvSeriesDetailState(
  //       tvSeriesState: RequestState.Loaded,
  //       tvSeries: tTvSeriesDetail,
  //       recommendationState: RequestState.Loading,
  //     ),
  //   );

  //   await tester.pumpWidget(makeTestableWidget());

  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });
}
