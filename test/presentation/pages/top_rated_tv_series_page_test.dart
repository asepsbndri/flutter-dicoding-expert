// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
// import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
// import 'package:ditonton/presentation/widgets/tv_series_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import '../../dummy_data/dummy_objects.dart';
// import 'top_rated_tv_series_page_test.mocks.dart';

// @GenerateMocks([TopRatedTvSeriesNotifier])
// void main() {
//   late MockTopRatedTvSeriesNotifier mockNotifier;

//   setUp(() {
//     mockNotifier = MockTopRatedTvSeriesNotifier();
//   });

//   Widget makeTestableWidget(Widget body) {
//     return ChangeNotifierProvider<TopRatedTvSeriesNotifier>.value(
//       value: mockNotifier,
//       child: MaterialApp(home: body),
//     );
//   }

//   testWidgets('Should display loading indicator when state is loading',
//       (WidgetTester tester) async {
//     when(mockNotifier.state).thenReturn(RequestState.Loading);

//     await tester.pumpWidget(makeTestableWidget(TopRatedTvSeriesPage()));

//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('Should display TvSeriesCard when data is loaded',
//       (WidgetTester tester) async {
//     when(mockNotifier.state).thenReturn(RequestState.Loaded);
//     when(mockNotifier.tvSeries).thenReturn([testTvSeries]);

//     await tester.pumpWidget(makeTestableWidget(TopRatedTvSeriesPage()));

//     expect(find.byType(TvSeriesCard), findsOneWidget);
//   });

//   testWidgets('Should display error message when state is error',
//       (WidgetTester tester) async {
//     when(mockNotifier.state).thenReturn(RequestState.Error);
//     when(mockNotifier.message).thenReturn('Failed to fetch data');

//     await tester.pumpWidget(makeTestableWidget(TopRatedTvSeriesPage()));

//     expect(find.text('Failed to fetch data'), findsOneWidget);
//   });
// }
