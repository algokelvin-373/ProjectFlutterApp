import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/tv_show_detail_body_page.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'package:provider/provider.dart';

import '../../../common/state_enum.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvShow';
  final int id;

  const TvShowDetailPage({super.key, required this.id});

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvShowDetailNotifier>(context, listen: false)
          .fetchTvShowDetail(widget.id);
      Provider.of<TvShowDetailNotifier>(context, listen: false)
          .loadWatchlistTvShowStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvShowDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvShowState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvShowState == RequestState.Loaded) {
            final tvShow = provider.tvShow;
            return SafeArea(
              child: TvShowDetailBodyPage(
                tvShow: tvShow,
                recommendations: provider.tvShowRecommendations,
                isAddedWatchlist: provider.isAddedToWatchlistTvShow,
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
