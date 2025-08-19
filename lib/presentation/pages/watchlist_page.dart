import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/tv_series.dart';
import '../widgets/tv_series_card.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
          .fetchWatchlistTvSeries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer2<WatchlistMovieNotifier, WatchlistTvSeriesNotifier>(
          builder: (context, movieData, tvData, child) {
            if (movieData.watchlistState == RequestState.Loading ||
                tvData.watchlistState == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (movieData.watchlistState == RequestState.Loaded &&
                tvData.watchlistState == RequestState.Loaded) {
              final allWatchlist = [
                ...movieData.watchlistMovies
                    .map((m) => {'type': 'movie', 'data': m}),
                ...tvData.watchlistTvSeries
                    .map((t) => {'type': 'tv', 'data': t}),
              ];

              return ListView.builder(
                itemCount: allWatchlist.length,
                itemBuilder: (context, index) {
                  final item = allWatchlist[index];
                  if (item['type'] == 'movie') {
                    return MovieCard(item['data'] as Movie);
                  } else {
                    return TvSeriesCard(item['data'] as TvSeries);
                  }
                },
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(movieData.message.isNotEmpty
                    ? movieData.message
                    : tvData.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
