// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/presentation/pages/search_page.dart';
// import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
// import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
// import 'package:ditonton/presentation/widgets/movie_card_list.dart';
// import 'package:ditonton/presentation/widgets/tv_series_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import '../../dummy_data/dummy_objects.dart';
// import 'search_page_test.mocks.dart';

// @GenerateMocks([MovieSearchNotifier, TvSeriesSearchNotifier])
// void main() {
//   late MockMovieSearchNotifier mockMovieNotifier;
//   late MockTvSeriesSearchNotifier mockTvNotifier;

//   setUp(() {
//     mockMovieNotifier = MockMovieSearchNotifier();
//     mockTvNotifier = MockTvSeriesSearchNotifier();
//   });

//   Widget makeTestableWidget(Widget body) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<MovieSearchNotifier>.value(
//             value: mockMovieNotifier),
//         ChangeNotifierProvider<TvSeriesSearchNotifier>.value(
//             value: mockTvNotifier),
//       ],
//       child: MaterialApp(home: body),
//     );
//   }

//   testWidgets('Should show loading indicator when searching movies',
//       (tester) async {
//     when(mockMovieNotifier.state).thenReturn(RequestState.Loading);
//     when(mockTvNotifier.state).thenReturn(RequestState.Empty);

//     await tester.pumpWidget(makeTestableWidget(SearchPage()));

//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('Should show MovieCard when search movie success',
//       (tester) async {
//     when(mockMovieNotifier.state).thenReturn(RequestState.Loaded);
//     when(mockMovieNotifier.searchResult).thenReturn([testMovie]);
//     when(mockTvNotifier.state).thenReturn(RequestState.Empty);

//     await tester.pumpWidget(makeTestableWidget(SearchPage()));

//     expect(find.byType(MovieCard), findsOneWidget);
//   });

//   testWidgets('Should show TvSeriesCard when search tv series success',
//       (tester) async {
//     when(mockMovieNotifier.state).thenReturn(RequestState.Empty);
//     when(mockTvNotifier.state).thenReturn(RequestState.Loaded);
//     when(mockTvNotifier.searchResult).thenReturn([testTvSeries]);

//     await tester.pumpWidget(makeTestableWidget(SearchPage()));

//     // Tap tab "TV Series"
//     await tester.tap(find.text('TV Series'));
//     await tester.pump(); // biar rebuild
//     await tester.pump(const Duration(milliseconds: 300)); // kasih waktu animasi

//     expect(find.byType(TvSeriesCard), findsOneWidget);
//   });

//   testWidgets('Should show empty container when state empty', (tester) async {
//     when(mockMovieNotifier.state).thenReturn(RequestState.Empty);
//     when(mockTvNotifier.state).thenReturn(RequestState.Empty);

//     await tester.pumpWidget(makeTestableWidget(SearchPage()));

//     expect(find.byType(Container), findsWidgets);
//   });
// }
