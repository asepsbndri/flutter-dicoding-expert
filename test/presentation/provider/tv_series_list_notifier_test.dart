// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/usecases/get_on_airing_tv_series.dart';
// import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
// import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
// import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'tv_series_list_notifier_test.mocks.dart';

// @GenerateMocks([
//   GetOnAiringTvSeries,
//   GetPopularTvSeries,
//   GetTopRatedTvSeries,
// ])
// void main() {
//   late TvSeriesListNotifier provider;
//   late MockGetOnAiringTvSeries mockGetOnAiringTvSeries;
//   late MockGetPopularTvSeries mockGetPopularTvSeries;
//   late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
//   late int listenerCallCount;

//   setUp(() {
//     mockGetOnAiringTvSeries = MockGetOnAiringTvSeries();
//     mockGetPopularTvSeries = MockGetPopularTvSeries();
//     mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
//     provider = TvSeriesListNotifier(
//       getOnAiringTvSeries: mockGetOnAiringTvSeries,
//       getPopularTvSeries: mockGetPopularTvSeries,
//       getTopRatedTvSeries: mockGetTopRatedTvSeries,
//     );
//     listenerCallCount = 0;
//     provider.addListener(() {
//       listenerCallCount += 1;
//     });
//   });

//   final tTvSeries = TvSeries(
//     adult: false,
//     backdropPath: 'backdropPath',
//     firstAirDate: '2020-05-05',
//     genreIds: [1, 2, 3],
//     id: 1,
//     name: 'Test Series',
//     originalName: 'Original Name',
//     overview: 'Overview',
//     popularity: 120.0,
//     posterPath: 'posterPath',
//     voteAverage: 8.5,
//     voteCount: 100,
//   );

//   final tTvSeriesList = <TvSeries>[tTvSeries];

//   group('On Airing TvSeries', () {
//     test('should change state to Loading when usecase is called', () async {
//       // arrange
//       when(mockGetOnAiringTvSeries.execute())
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       provider.fetchOnAiringTvSeries();
//       // assert
//       expect(provider.onAiringState, RequestState.Loading);
//     });

//     test('should update data when successful', () async {
//       // arrange
//       when(mockGetOnAiringTvSeries.execute())
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       await provider.fetchOnAiringTvSeries();
//       // assert
//       expect(provider.onAiringState, RequestState.Loaded);
//       expect(provider.onAiringTvSeries, tTvSeriesList);
//       expect(listenerCallCount, greaterThan(1));
//     });

//     test('should return error when unsuccessful', () async {
//       // arrange
//       when(mockGetOnAiringTvSeries.execute())
//           .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
//       // act
//       await provider.fetchOnAiringTvSeries();
//       // assert
//       expect(provider.onAiringState, RequestState.Error);
//       expect(provider.message, 'Server Failure');
//     });
//   });

//   group('Popular TvSeries', () {
//     test('should update data when successful', () async {
//       // arrange
//       when(mockGetPopularTvSeries.execute())
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       await provider.fetchPopularTvSeries();
//       // assert
//       expect(provider.popularTvSeriesState, RequestState.Loaded);
//       expect(provider.popularTvSeries, tTvSeriesList);
//     });

//     test('should return error when unsuccessful', () async {
//       // arrange
//       when(mockGetPopularTvSeries.execute())
//           .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
//       // act
//       await provider.fetchPopularTvSeries();
//       // assert
//       expect(provider.popularTvSeriesState, RequestState.Error);
//       expect(provider.message, 'Server Failure');
//     });
//   });

//   group('Top Rated TvSeries', () {
//     test('should update data when successful', () async {
//       // arrange
//       when(mockGetTopRatedTvSeries.execute())
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       await provider.fetchTopRatedTvSeries();
//       // assert
//       expect(provider.topRatedTvSeriesState, RequestState.Loaded);
//       expect(provider.topRatedTvSeries, tTvSeriesList);
//     });

//     test('should return error when unsuccessful', () async {
//       // arrange
//       when(mockGetTopRatedTvSeries.execute())
//           .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
//       // act
//       await provider.fetchTopRatedTvSeries();
//       // assert
//       expect(provider.topRatedTvSeriesState, RequestState.Error);
//       expect(provider.message, 'Server Failure');
//     });
//   });
// }
