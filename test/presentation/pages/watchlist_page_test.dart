// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/presentation/pages/watchlist_page.dart';
// import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
// import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
// import 'package:ditonton/presentation/widgets/movie_card_list.dart';
// import 'package:ditonton/presentation/widgets/tv_series_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import '../../dummy_data/dummy_objects.dart';
// import 'watchlist_page_test.mocks.dart';

// @GenerateMocks([WatchlistMovieNotifier, WatchlistTvSeriesNotifier])
// void main() {
//   late MockWatchlistMovieNotifier mockMovieNotifier;
//   late MockWatchlistTvSeriesNotifier mockTvNotifier;

//   setUp(() {
//     mockMovieNotifier = MockWatchlistMovieNotifier();
//     mockTvNotifier = MockWatchlistTvSeriesNotifier();
//   });

//   Widget makeTestableWidget(Widget body) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<WatchlistMovieNotifier>.value(
//             value: mockMovieNotifier),
//         ChangeNotifierProvider<WatchlistTvSeriesNotifier>.value(
//             value: mockTvNotifier),
//       ],
//       child: MaterialApp(home: body),
//     );
//   }

//   testWidgets('Should show CircularProgressIndicator when loading',
//       (WidgetTester tester) async {
//     when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Loading);
//     when(mockTvNotifier.watchlistState).thenReturn(RequestState.Loading);

//     await tester.pumpWidget(makeTestableWidget(WatchlistPage()));

//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('Should show MovieCard and TvSeriesCard when data loaded',
//       (WidgetTester tester) async {
//     when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Loaded);
//     when(mockMovieNotifier.watchlistMovies).thenReturn([testMovie]);

//     when(mockTvNotifier.watchlistState).thenReturn(RequestState.Loaded);
//     when(mockTvNotifier.watchlistTvSeries).thenReturn([testTvSeries]);

//     await tester.pumpWidget(makeTestableWidget(WatchlistPage()));

//     expect(find.byType(MovieCard), findsOneWidget);
//     expect(find.byType(TvSeriesCard), findsOneWidget);
//   });

//   testWidgets('Should show error message when error state',
//       (WidgetTester tester) async {
//     when(mockMovieNotifier.watchlistState).thenReturn(RequestState.Error);
//     when(mockMovieNotifier.message).thenReturn('Failed to fetch movies');

//     when(mockTvNotifier.watchlistState).thenReturn(RequestState.Error);
//     when(mockTvNotifier.message).thenReturn('Failed to fetch tv');

//     await tester.pumpWidget(makeTestableWidget(WatchlistPage()));

//     expect(find.text('Failed to fetch movies'), findsOneWidget);
//   });
// }
