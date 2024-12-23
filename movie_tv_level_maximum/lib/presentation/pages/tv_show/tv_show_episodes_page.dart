import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/tv_show_episodes_body_page.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_episodes_notifier.dart';
import 'package:provider/provider.dart';

import '../../../common/state_enum.dart';

class TvShowEpisodesPage extends StatefulWidget {
  static const ROUTE_NAME = '/season-episodes';
  final int id;
  final int season;

  const TvShowEpisodesPage({
    super.key,
    required this.id,
    required this.season,
  });

  @override
  State<TvShowEpisodesPage> createState() => _TvShowEpisodesPageState();
}

class _TvShowEpisodesPageState extends State<TvShowEpisodesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvShowEpisodesNotifier>(context, listen: false)
          .fetchTvShowEpisodes(widget.id, widget.season);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvShowEpisodesNotifier>(
        builder: (context, provider, child) {
          if (provider.tvShowEpisodeState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvShowEpisodeState == RequestState.Loaded) {
            print('Result data : ${provider.tvShowEpisode}');
            return SafeArea(
              child: TvShowEpisodesBodyPage(
                tvShowEpisodes: provider.tvShowEpisode,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}
