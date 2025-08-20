import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';

import '../bloc/popular_tv_series_bloc.dart';
import '../bloc/popular_tv_series_event.dart';
import '../bloc/popular_tv_series_state.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  const PopularTvSeriesPage({Key? key}) : super(key: key);

  @override
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularTvSeriesBloc>().add(FetchPopularTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
          builder: (context, state) {
            if (state.state == RequestState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvSeries[index];
                  return TvSeriesCard(tv);
                },
                itemCount: state.tvSeries.length,
              );
            } else if (state.state == RequestState.Error) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(child: Text('No Data'));
            }
          },
        ),
      ),
    );
  }
}
