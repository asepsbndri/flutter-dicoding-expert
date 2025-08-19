import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeriesStatus usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchlistTvSeriesStatus(mockTvSeriesRepository);
  });

  const tId = 1;

  test('should return watchlist status (true) when tv series is added', () async {
    // arrange
    when(mockTvSeriesRepository.isAddedToWatchlist(tId))
        .thenAnswer((_) async => true);

    // act
    final result = await usecase.execute(tId);

    // assert
    expect(result, true);
    verify(mockTvSeriesRepository.isAddedToWatchlist(tId));
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });

  test('should return watchlist status (false) when tv series is not added', () async {
    // arrange
    when(mockTvSeriesRepository.isAddedToWatchlist(tId))
        .thenAnswer((_) async => false);

    // act
    final result = await usecase.execute(tId);

    // assert
    expect(result, false);
    verify(mockTvSeriesRepository.isAddedToWatchlist(tId));
    verifyNoMoreInteractions(mockTvSeriesRepository);
  });
}
