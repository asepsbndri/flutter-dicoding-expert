import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tv_series_search_notifier.dart';
import '../widgets/tv_series_card.dart';

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
      // Movie
      Provider.of<MovieSearchNotifier>(context, listen: false)
          .fetchMovieSearch(query);
    } else {
      // TV Series
      Provider.of<TvSeriesSearchNotifier>(context, listen: false)
          .fetchTvSeriesSearch(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
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
                decoration: InputDecoration(
                  hintText: 'Search title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.search,
              ),
              SizedBox(height: 16),
              Text('Search Result', style: kHeading6),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Movies
                    Consumer<MovieSearchNotifier>(
                      builder: (context, data, child) {
                        if (data.state == RequestState.Loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (data.state == RequestState.Loaded) {
                          final result = data.searchResult;
                          return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    // TV Series
                    Consumer<TvSeriesSearchNotifier>(
                      builder: (context, data, child) {
                        if (data.state == RequestState.Loading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (data.state == RequestState.Loaded) {
                          final result = data.searchResult;
                          return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tv = result[index];
                              return TvSeriesCard(tv);
                            },
                            itemCount: result.length,
                          );
                        } else {
                          return Container();
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
