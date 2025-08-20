import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tv_series_search_event.dart';
import 'tv_series_search_state.dart';

class TvSeriesSearchBloc extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchBloc(this.searchTvSeries) : super(TvSeriesSearchEmpty()) {
    on<OnTvSeriesQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvSeriesSearchLoading());

      final result = await searchTvSeries.execute(query);

      result.fold(
        (failure) => emit(TvSeriesSearchError(failure.message)),
        (data) => emit(TvSeriesSearchHasData(data)),
      );
    });
  }
}
