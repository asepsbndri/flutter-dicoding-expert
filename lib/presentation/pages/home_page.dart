import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'on_airing_tv_series_page.dart';
import 'popular_movies_page.dart';
import 'popular_tv_series_page.dart';
import 'top_rated_movies_page.dart';
import 'top_rated_tv_series_page.dart';
import 'tv_series_detail_page.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final movieProvider =
          Provider.of<MovieListNotifier>(context, listen: false);
      movieProvider
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies();

      final tvProvider =
          Provider.of<TvSeriesListNotifier>(context, listen: false);
      tvProvider
        ..fetchOnAiringTvSeries()
        ..fetchPopularTvSeries()
        ..fetchTopRatedTvSeries();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                if (data.onAiringState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.onAiringState == RequestState.Loaded) {
                  return TvSeriesList(data.onAiringTvSeries);
                } else {
                  return Text('Failed');
                }
              }),
              SubHeading(
                title: "Popular TV Series",
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME);
                },
              ),
              Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                if (data.popularTvSeriesState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.popularTvSeriesState == RequestState.Loaded) {
                  return TvSeriesList(data.popularTvSeries);
                } else {
                  return Text('Failed');
                }
              }),
              SubHeading(
                title: "Top Rated TV Series",
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME);
                },
              ),
              Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                if (data.topRatedTvSeriesState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.topRatedTvSeriesState == RequestState.Loaded) {
                  return TvSeriesList(data.topRatedTvSeries);
                } else {
                  return Text('Failed');
                }
              }),

              SizedBox(height: 20),

              Text("Now Playing Movies", style: kHeading6),

              /// ---------------- MOVIES ----------------
              // SubHeading(
              //   title: "Now Playing Movies",
              //   onTap: () {
              //     // Navigator.pushNamed(context, NowPlayingMoviesPage.ROUTE_NAME);
              //   },
              // ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                if (data.nowPlayingState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.nowPlayingState == RequestState.Loaded) {
                  return MovieList(data.nowPlayingMovies);
                } else {
                  return Text('Failed');
                }
              }),
              SubHeading(
                title: "Popular Movies",
                onTap: () {
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME);
                },
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                if (data.popularMoviesState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.popularMoviesState == RequestState.Loaded) {
                  return MovieList(data.popularMovies);
                } else {
                  return Text('Failed');
                }
              }),
              SubHeading(
                title: "Top Rated Movies",
                onTap: () {
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME);
                },
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                if (data.topRatedMoviesState == RequestState.Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (data.topRatedMoviesState == RequestState.Loaded) {
                  return MovieList(data.topRatedMovies);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/// SUBHEADING WIDGET
class SubHeading extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SubHeading({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Text(
              "See More",
              style: TextStyle(color: kMikadoYellow),
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
    return SizedBox(
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
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
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
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvSeries.length,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
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
