// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/usecases/search_tv_series.dart';
// import 'package:ditonton/presentation/provider/tv_series_search_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'tv_series_search_notifier_test.mocks.dart';

// @GenerateMocks([SearchTvSeries])
// void main() {
//   late TvSeriesSearchNotifier provider;
//   late MockSearchTvSeries mockSearchTvSeries;
//   late int listenerCallCount;

//   setUp(() {
//     mockSearchTvSeries = MockSearchTvSeries();
//     provider = TvSeriesSearchNotifier(searchTvSeries: mockSearchTvSeries);
//     listenerCallCount = 0;
//     provider.addListener(() {
//       listenerCallCount++;
//     });
//   });

//   final tTvSeries = TvSeries(
//     adult: false,
//     backdropPath: "backdropPath",
//     firstAirDate: "2020-05-05",
//     genreIds: [1, 2, 3],
//     id: 1,
//     name: "Test Series",
//     originalName: "Original Name",
//     overview: "Overview",
//     popularity: 123.4,
//     posterPath: "posterPath",
//     voteAverage: 8.0,
//     voteCount: 200,
//   );

//   final tTvSeriesList = <TvSeries>[tTvSeries];
//   final tQuery = "Test";

//   group('search tv series', () {
//     test('should change state to loading when search is called', () async {
//       // arrange
//       when(mockSearchTvSeries.execute(tQuery))
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       provider.fetchTvSeriesSearch(tQuery);
//       // assert
//       expect(provider.state, RequestState.Loading);
//       expect(listenerCallCount, 1);
//     });

//     test('should return tv series when data is gotten successfully', () async {
//       // arrange
//       when(mockSearchTvSeries.execute(tQuery))
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       await provider.fetchTvSeriesSearch(tQuery);
//       // assert
//       expect(provider.state, RequestState.Loaded);
//       expect(provider.searchResult, tTvSeriesList);
//       expect(listenerCallCount, greaterThan(1));
//     });

//     test('should return error when search fails', () async {
//       // arrange
//       when(mockSearchTvSeries.execute(tQuery))
//           .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
//       // act
//       await provider.fetchTvSeriesSearch(tQuery);
//       // assert
//       expect(provider.state, RequestState.Error);
//       expect(provider.message, "Server Failure");
//       expect(listenerCallCount, greaterThan(1));
//     });
//   });
// }
