import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/on_the_air_tv_shows_page.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/popular_tv_shows_page.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/top_rated_tv_shows_page.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/tv_show_list_widget.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_list_notifier.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/state_enum.dart';

class TvShowPageWidget extends StatelessWidget {
  const TvShowPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Airing Today',
          style: kHeading6,
        ),
        Consumer<TvShowListNotifier>(builder: (context, data, child) {
          final state = data.airingTodayState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return TvShowList(data.airingTodayTvShows);
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'On The Air',
          onTap: () =>
              Navigator.pushNamed(context, OnTheAirTvShowsPage.ROUTE_NAME),
        ),
        Consumer<TvShowListNotifier>(builder: (context, data, child) {
          final state = data.onTheAirState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return TvShowList(data.onTheAirTvShows);
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularTvShowsPage.ROUTE_NAME),
        ),
        Consumer<TvShowListNotifier>(builder: (context, data, child) {
          final state = data.popularState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return TvShowList(data.popularTvShows);
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              Navigator.pushNamed(context, TopRatedTvShowsPage.ROUTE_NAME),
        ),
        Consumer<TvShowListNotifier>(builder: (context, data, child) {
          final state = data.topRatedState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return TvShowList(data.topRatedTvShows);
          } else {
            return Text('Failed');
          }
        }),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
