import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:ditonton/presentation/bloc/tv_series_search_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_event.dart';
import 'package:ditonton/presentation/bloc/tv_series_search_state.dart';

import '../bloc/movies_search_bloc.dart';
import '../bloc/movies_search_event.dart';
import '../bloc/movies_search_state.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (_tabController.index == 0) {
      // Movies
      context.read<MovieSearchBloc>().add(OnMovieQueryChanged(query));
    } else {
      // TV Series
      context.read<TvSeriesSearchBloc>().add(OnTvSeriesQueryChanged(query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Movies"),
              Tab(text: "TV Series"),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _queryController,
                onSubmitted: _onSearch,
                decoration: const InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 16),
              Text('Search Result', style: kHeading6),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Movies -> pakai Bloc
                    BlocBuilder<MovieSearchBloc, MovieSearchState>(
                      builder: (context, state) {
                        if (state is MovieSearchLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is MovieSearchHasData) {
                          final result = state.result;
                          return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          );
                        } else if (state is MovieSearchError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const Center(child: Text("Cari Film"));
                        }
                      },
                    ),

                    // TV Series -> pakai Bloc
                    BlocBuilder<TvSeriesSearchBloc, TvSeriesSearchState>(
                      builder: (context, state) {
                        if (state is TvSeriesSearchLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is TvSeriesSearchHasData) {
                          final result = state.result;
                          return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tv = result[index];
                              return TvSeriesCard(tv);
                            },
                            itemCount: result.length,
                          );
                        } else if (state is TvSeriesSearchError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const Center(child: Text("Cari TV Series"));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
