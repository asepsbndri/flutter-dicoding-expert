import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'popular_tv_series_event.dart';
import 'popular_tv_series_state.dart';
import 'package:ditonton/common/state_enum.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesBloc(this.getPopularTvSeries)
      : super(PopularTvSeriesState.initial()) {
    on<FetchPopularTvSeries>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));


      final result = await getPopularTvSeries.execute();
      result.fold(
        (failure) => emit(
          state.copyWith(state: RequestState.Error, message: failure.message),
        ),
        (tvSeriesData) => emit(
          state.copyWith(state: RequestState.Loaded, tvSeries: tvSeriesData),
        ),
      );
    });
  }
}
