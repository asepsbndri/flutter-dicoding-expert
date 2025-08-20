import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/watchlist_movies_bloc.dart';
import '../bloc/watchlist_movies_event.dart';
import '../bloc/watchlist_movies_state.dart';
import '../bloc/watchlist_tv_series_bloc.dart';
import '../bloc/watchlist_tv_series_event.dart';
import '../bloc/watchlist_tv_series_state.dart';

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
      context.read<WatchlistMovieBloc>().add(FetchWatchlistMovies());
      context.read<WatchlistTvBloc>().add(FetchWatchlistTvSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovies());
    context.read<WatchlistTvBloc>().add(FetchWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MultiBlocBuilder<WatchlistMovieBloc, WatchlistMovieState,
            WatchlistTvBloc, WatchlistTvState>(
          builder: (context, movieState, tvState) {
            if (movieState.watchlistState == RequestState.Loading ||
                tvState.watchlistState == RequestState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (movieState.watchlistState == RequestState.Loaded &&
                tvState.watchlistState == RequestState.Loaded) {
              final allWatchlist = [
                ...movieState.watchlistMovies
                    .map((m) => {'type': 'movie', 'data': m}),
                ...tvState.watchlistTvSeries
                    .map((t) => {'type': 'tv', 'data': t}),
              ];

              if (allWatchlist.isEmpty) {
                return const Center(child: Text('Watchlist masih kosong'));
              }

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
                key: const Key('error_message'),
                child: Text(
                  movieState.message.isNotEmpty
                      ? movieState.message
                      : tvState.message,
                ),
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


class MultiBlocBuilder<B1 extends StateStreamable<S1>, S1,
    B2 extends StateStreamable<S2>, S2> extends StatelessWidget {
  final BlocWidgetBuilder2<S1, S2> builder;

  const MultiBlocBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B1, S1>(
      builder: (context, state1) {
        return BlocBuilder<B2, S2>(
          builder: (context, state2) {
            return builder(context, state1, state2);
          },
        );
      },
    );
  }
}

typedef BlocWidgetBuilder2<S1, S2> = Widget Function(
  BuildContext context,
  S1 state1,
  S2 state2,
);
