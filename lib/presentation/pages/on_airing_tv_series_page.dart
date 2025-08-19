import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/on_airing_tv_series_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Future.microtask(() =>
        Provider.of<OnAiringTvSeriesNotifier>(context, listen: false)
            .fetchOnAiringTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Airing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnAiringTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvSeries[index];
                  return TvSeriesCard(tv);
                },
                itemCount: data.tvSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
