// lib/injection.dart
import 'package:ditonton/pinned_http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

// data sources
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';

// repositories
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

// usecases
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies_status.dart';
import 'package:ditonton/domain/usecases/save_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';

import 'package:ditonton/domain/usecases/get_on_airing_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';

// bloc
import 'package:ditonton/presentation/bloc/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_search_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_bloc.dart';

import 'package:ditonton/presentation/bloc/tv_series_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/on_airing_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_series_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // 1) Buat IOClient yang dipinning
  // Mulai dari mode aman (tanpa file cert) untuk memastikan koneksi OK
  // final ioClient = await SslPinning.ioClientSafe();

  // Jika ingin strict (setelah yakin file .pem benar), ganti ke:
  final ioClient = await SslPinning.ioClientStrict(
    assetPemPath: 'assets/certificates.cer',
  );

  // 2) Daftarkan IOClient dan alias untuk http.Client
  locator.registerLazySingleton<IOClient>(() => ioClient);
  locator.registerLazySingleton<http.Client>(() => locator<IOClient>());

  // 3) Data sources (semua gunakan http.Client dari locator)
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator<http.Client>()),
  );
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(client: locator<http.Client>()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
    () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()),
  );

  // 4) Repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // 5) Use cases — Movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovies(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // 6) Use cases — TV Series
  locator.registerLazySingleton(() => GetOnAiringTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // 7) Bloc / Provider
  locator.registerFactory(() => MovieListBloc(
        getNowPlayingMovies: locator(),
        getPopularMovies: locator(),
        getTopRatedMovies: locator(),
      ));
  locator.registerFactory(() => MovieDetailBloc(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => TopRatedMoviesBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));

  locator.registerFactory(() => TvSeriesListBloc(
        getOnAiringTvSeries: locator(),
        getPopularTvSeries: locator(),
        getTopRatedTvSeries: locator(),
      ));
  locator.registerFactory(() => TvSeriesDetailBloc(
        getTvSeriesDetail: locator(),
        getTvSeriesRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));
  locator.registerFactory(() => TvSeriesSearchBloc(locator()));
  locator.registerFactory(() => PopularTvSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedTvSeriesBloc(locator()));
  locator.registerFactory(() => OnAiringTvSeriesBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(locator()));

  // 8) Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
