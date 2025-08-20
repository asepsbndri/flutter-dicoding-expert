import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/on_airing_tv_series_bloc.dart';
import '../bloc/on_airing_tv_series_event.dart';
import '../bloc/on_airing_tv_series_state.dart';

class OnAiringTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-airing-tv';

  const OnAiringTvSeriesPage({Key? key}) : super(key: key);

  @override
  _OnAiringTvSeriesPageState createState() => _OnAiringTvSeriesPageState();
}

class _OnAiringTvSeriesPageState extends State<OnAiringTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnAiringTvSeriesBloc>().add(FetchOnAiringTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Airing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAiringTvSeriesBloc, OnAiringTvSeriesState>(
          builder: (context, state) {
            if (state.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == RequestState.Loaded) {
              return ListView.builder(
                itemCount: state.tvSeries.length,
                itemBuilder: (context, index) {
                  final tv = state.tvSeries[index];
                  return TvSeriesCard(tv);
                },
              );
            } else if (state.state == RequestState.Error) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Tidak ada data'),
              );
            }
          },
        ),
      ),
    );
  }
}
