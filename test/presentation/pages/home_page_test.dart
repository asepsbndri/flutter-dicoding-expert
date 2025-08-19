import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([MovieListNotifier, TvSeriesListNotifier])
void main() {
  late MockMovieListNotifier mockMovieNotifier;
  late MockTvSeriesListNotifier mockTvNotifier;

  setUp(() {
    mockMovieNotifier = MockMovieListNotifier();
    mockTvNotifier = MockTvSeriesListNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieListNotifier>.value(value: mockMovieNotifier),
        ChangeNotifierProvider<TvSeriesListNotifier>.value(value: mockTvNotifier),
      ],
      child: MaterialApp(home: body),
    );
  }

  testWidgets('HomePage should display progress indicators when loading',
      (tester) async {
    when(mockMovieNotifier.nowPlayingState).thenReturn(RequestState.Loading);
    when(mockMovieNotifier.popularMoviesState).thenReturn(RequestState.Loading);
    when(mockMovieNotifier.topRatedMoviesState).thenReturn(RequestState.Loading);
    when(mockTvNotifier.onAiringState).thenReturn(RequestState.Loading);
    when(mockTvNotifier.popularTvSeriesState).thenReturn(RequestState.Loading);
    when(mockTvNotifier.topRatedTvSeriesState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(makeTestableWidget(HomePage()));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('HomePage should display list when data is loaded',
      (tester) async {
    when(mockMovieNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.popularMoviesState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.topRatedMoviesState).thenReturn(RequestState.Loaded);
    when(mockMovieNotifier.nowPlayingMovies).thenReturn([testMovie]);
    when(mockMovieNotifier.popularMovies).thenReturn([testMovie]);
    when(mockMovieNotifier.topRatedMovies).thenReturn([testMovie]);

    when(mockTvNotifier.onAiringState).thenReturn(RequestState.Loaded);
    when(mockTvNotifier.popularTvSeriesState).thenReturn(RequestState.Loaded);
    when(mockTvNotifier.topRatedTvSeriesState).thenReturn(RequestState.Loaded);
    when(mockTvNotifier.onAiringTvSeries).thenReturn([testTvSeries]);
    when(mockTvNotifier.popularTvSeries).thenReturn([testTvSeries]);
    when(mockTvNotifier.topRatedTvSeries).thenReturn([testTvSeries]);

    await tester.pumpWidget(makeTestableWidget(HomePage()));

    expect(find.byType(ListView), findsWidgets);
  });

}
