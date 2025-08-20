// import 'package:dartz/dartz.dart';
// import 'package:ditonton/common/failure.dart';
// import 'package:ditonton/common/state_enum.dart';
// import 'package:ditonton/domain/entities/genre.dart';
// import 'package:ditonton/domain/entities/tv_series.dart';
// import 'package:ditonton/domain/entities/tv_series_detail.dart';
// import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
// import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
// import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
// import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
// import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
// import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'tv_series_detail_notifier_test.mocks.dart';

// @GenerateMocks([
//   GetTvSeriesDetail,
//   GetTvSeriesRecommendations,
//   GetWatchlistTvSeriesStatus,
//   SaveWatchlistTvSeries,
//   RemoveWatchlistTvSeries,
// ])
// void main() {
//   late TvSeriesDetailNotifier provider;
//   late MockGetTvSeriesDetail mockGetTvSeriesDetail;
//   late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
//   late MockGetWatchlistTvSeriesStatus mockGetWatchlistTvSeriesStatus;
//   late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
//   late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
//   late int listenerCallCount;

//   setUp(() {
//     mockGetTvSeriesDetail = MockGetTvSeriesDetail();
//     mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
//     mockGetWatchlistTvSeriesStatus = MockGetWatchlistTvSeriesStatus();
//     mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
//     mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
//     provider = TvSeriesDetailNotifier(
//       getTvSeriesDetail: mockGetTvSeriesDetail,
//       getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
//       getWatchListStatus: mockGetWatchlistTvSeriesStatus,
//       saveWatchlist: mockSaveWatchlistTvSeries,
//       removeWatchlist: mockRemoveWatchlistTvSeries,
//     );
//     listenerCallCount = 0;
//     provider.addListener(() {
//       listenerCallCount += 1;
//     });
//   });

//   const tId = 1;

//   final tTvSeriesDetail = TvSeriesDetail(
//     backdropPath: 'backdropPath',
//     genres: [Genre(id: 1, name: 'Action')],
//     id: 1,
//     name: 'Test Series',
//     overview: 'Overview',
//     posterPath: 'posterPath',
//     firstAirDate: '2020-05-05',
//     voteAverage: 8.5,
//     voteCount: 100,
//     numberOfEpisodes: 10,
//     numberOfSeasons: 1,
//   );

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

//   group('Get TvSeries Detail', () {
//     test('should get data from the usecase', () async {
//       // arrange
//       when(mockGetTvSeriesDetail.execute(tId))
//           .thenAnswer((_) async => Right(tTvSeriesDetail));
//       when(mockGetTvSeriesRecommendations.execute(tId))
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       await provider.fetchTvSeriesDetail(tId);
//       // assert
//       expect(provider.tvSeriesState, RequestState.Loaded);
//       expect(provider.tvSeries, tTvSeriesDetail);
//       expect(provider.recommendationState, RequestState.Loaded);
//       expect(provider.tvSeriesRecommendations, tTvSeriesList);
//       expect(listenerCallCount, greaterThan(1));
//     });

//     test('should return error when data is unsuccessful', () async {
//       // arrange
//       when(mockGetTvSeriesDetail.execute(tId))
//           .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
//       when(mockGetTvSeriesRecommendations.execute(tId))
//           .thenAnswer((_) async => Right(tTvSeriesList));
//       // act
//       await provider.fetchTvSeriesDetail(tId);
//       // assert
//       expect(provider.tvSeriesState, RequestState.Error);
//       expect(provider.message, 'Server Failure');
//     });

//     test('should return error when recommendation fails', () async {
//       // arrange
//       when(mockGetTvSeriesDetail.execute(tId))
//           .thenAnswer((_) async => Right(tTvSeriesDetail));
//       when(mockGetTvSeriesRecommendations.execute(tId)).thenAnswer(
//           (_) async => Left(ServerFailure('Recommendation Failure')));
//       // act
//       await provider.fetchTvSeriesDetail(tId);
//       // assert
//       expect(provider.recommendationState, RequestState.Error);
//       expect(provider.message, 'Recommendation Failure');
//     });
//   });

//   group('Watchlist', () {
//     test('should get the watchlist status', () async {
//       // arrange
//       when(mockGetWatchlistTvSeriesStatus.execute(1))
//           .thenAnswer((_) async => true);
//       // act
//       await provider.loadWatchlistStatus(1);
//       // assert
//       expect(provider.isAddedToWatchlist, true);
//     });

//     test('should execute save watchlist when function called', () async {
//       // arrange
//       when(mockSaveWatchlistTvSeries.execute(tTvSeriesDetail))
//           .thenAnswer((_) async => Right('Added to Watchlist'));
//       when(mockGetWatchlistTvSeriesStatus.execute(tTvSeriesDetail.id))
//           .thenAnswer((_) async => true);
//       // act
//       await provider.addWatchlist(tTvSeriesDetail);
//       // assert
//       expect(provider.watchlistMessage, 'Added to Watchlist');
//       expect(provider.isAddedToWatchlist, true);
//     });

//     test('should execute remove watchlist when function called', () async {
//       // arrange
//       when(mockRemoveWatchlistTvSeries.execute(tTvSeriesDetail))
//           .thenAnswer((_) async => Right('Removed from Watchlist'));
//       when(mockGetWatchlistTvSeriesStatus.execute(tTvSeriesDetail.id))
//           .thenAnswer((_) async => false);
//       // act
//       await provider.removeFromWatchlist(tTvSeriesDetail);
//       // assert
//       expect(provider.watchlistMessage, 'Removed from Watchlist');
//       expect(provider.isAddedToWatchlist, false);
//     });
//   });
// }
