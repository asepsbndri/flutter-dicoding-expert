import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/pages/on_airing_tv_series_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_list_bloc.dart';
import '../bloc/movie_list_event.dart';
import '../bloc/movie_list_state.dart' show MovieListState;
import '../bloc/tv_series_list_bloc.dart';
import '../bloc/tv_series_list_event.dart';
import '../bloc/tv_series_list_state.dart';

class HomePage extends StatelessWidget {
  static const ROUTE_NAME = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // trigger fetch data
    context.read<MovieListBloc>()
      ..add(FetchNowPlayingMovies())
      ..add(FetchPopularMovies())
      ..add(FetchTopRatedMovies());

    context.read<TvSeriesListBloc>()
      ..add(FetchOnAiringTvSeries())
      ..add(FetchPopularTvSeries())
      ..add(FetchTopRatedTvSeries());

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(color: Colors.grey.shade900),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------------- TV SERIES ----------------
              SubHeading(
                title: "Now Airing TV Series",
                onTap: () {
                  Navigator.pushNamed(context, OnAiringTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                builder: (context, state) {
                  if (state.onAiringState == RequestState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.onAiringState == RequestState.Loaded) {
                    return TvSeriesList(state.onAiringTvSeries);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              SubHeading(
                title: "Popular TV Series",
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                builder: (context, state) {
                  if (state.popularTvSeriesState == RequestState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.popularTvSeriesState == RequestState.Loaded) {
                    return TvSeriesList(state.popularTvSeries);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              SubHeading(
                title: "Top Rated TV Series",
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TvSeriesListBloc, TvSeriesListState>(
                builder: (context, state) {
                  if (state.topRatedTvSeriesState == RequestState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.topRatedTvSeriesState == RequestState.Loaded) {
                    return TvSeriesList(state.topRatedTvSeries);
                  } else {
                    return Text('Failed');
                  }
                },
              ),

              SizedBox(height: 20),

              Text("Now Playing Movies", style: kHeading6),

              /// ---------------- MOVIES ----------------
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state.nowPlayingState == RequestState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.nowPlayingState == RequestState.Loaded) {
                    return MovieList(state.nowPlayingMovies);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              SubHeading(
                title: "Popular Movies",
                onTap: () {
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state.popularMoviesState == RequestState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.popularMoviesState == RequestState.Loaded) {
                    return MovieList(state.popularMovies);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              SubHeading(
                title: "Top Rated Movies",
                onTap: () {
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  if (state.topRatedMoviesState == RequestState.Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.topRatedMoviesState == RequestState.Loaded) {
                    return MovieList(state.topRatedMovies);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubHeading extends StatelessWidget {
  final String title;
  final Function() onTap;

  const SubHeading({required this.title, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const TvSeriesList(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvSeries.length,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
