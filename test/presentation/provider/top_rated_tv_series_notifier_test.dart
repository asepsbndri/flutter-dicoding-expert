// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
// import 'package:ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'top_rated_tv_series_notifier_test.mocks.dart';

// @GenerateMocks([GetTopRatedTvSeries])
// void main() {
//   late TopRatedTvSeriesNotifier provider;
//   late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
//   late int listenerCallCount;

//   setUp(() {
//     listenerCallCount = 0;
//     mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
//     provider =
//         TopRatedTvSeriesNotifier(getTopRatedTvSeries: mockGetTopRatedTvSeries)
//           ..addListener(() {
//             listenerCallCount += 1;
//           });
//   });

//   final tTvSeries = TvSeries(
//     adult: false,
//     backdropPath: 'backdropPath',
//     firstAirDate: '2020-05-05',
//     genreIds: [1, 2, 3],
//     id: 1,
//     name: 'Top Rated Test Series',
//     originalName: 'Original Name',
//     overview: 'Overview',
//     popularity: 15.0,
//     posterPath: 'posterPath',
//     voteAverage: 9.0,
//     voteCount: 200,
//   );
//   final tTvSeriesList = <TvSeries>[tTvSeries];

//   group('fetch Top Rated Tv Series', () {
//     test('should change state to Loading when usecase is called', () {
//       // arrange
//       when(mockGetTopRatedTvSeries.execute())
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       provider.fetchTopRatedTvSeries();
//       // assert
//       expect(provider.state, RequestState.Loading);
//       expect(listenerCallCount, 1);
//     });

//     test('should change tvSeries when data is gotten successfully', () async {
//       // arrange
//       when(mockGetTopRatedTvSeries.execute())
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       await provider.fetchTopRatedTvSeries();
//       // assert
//       expect(provider.state, RequestState.Loaded);
//       expect(provider.tvSeries, tTvSeriesList);
//       expect(listenerCallCount, 2);
//     });

//     test('should return error when data is unsuccessful', () async {
//       // arrange
//       when(mockGetTopRatedTvSeries.execute())
//           .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
//       // act
//       await provider.fetchTopRatedTvSeries();
//       // assert
//       expect(provider.state, RequestState.Error);
//       expect(provider.message, 'Server Failure');
//       expect(listenerCallCount, 2);
//     });
//   });
// }
