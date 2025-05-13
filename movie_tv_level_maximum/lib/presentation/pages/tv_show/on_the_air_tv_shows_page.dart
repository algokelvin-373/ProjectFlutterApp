import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/on_the_air_tv_shows_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/widgets/tv_show_card_list.dart';
import 'package:provider/provider.dart';

import '../../../common/state_enum.dart';

class OnTheAirTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/onTheAir-tvShow';

  const OnTheAirTvShowsPage({super.key});

  @override
  State<OnTheAirTvShowsPage> createState() => _OnTheAirTvShowsPage();
}

class _OnTheAirTvShowsPage extends State<OnTheAirTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnTheAirTvShowsNotifier>(context, listen: false)
            .fetchOnTheAirTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirTvShowsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvShows[index];
                  return TvShowCard(tvShow);
                },
                itemCount: data.tvShows.length,
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
