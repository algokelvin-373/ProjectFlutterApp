import 'package:flutter/material.dart';
import 'package:movie_tv_level_maximum/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/state_enum.dart';
import '../../provider/movie/movie_list_notifier.dart';
import 'popular_movies_page.dart';
import 'movie_list_widget.dart';

class MoviePageWidget extends StatelessWidget {
  const MoviePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Now Playing',
          style: kHeading6,
        ),
        Consumer<MovieListNotifier>(builder: (context, data, child) {
          final state = data.nowPlayingState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return MovieList(data.nowPlayingMovies);
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Popular',
          onTap: () =>
              Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
        ),
        Consumer<MovieListNotifier>(builder: (context, data, child) {
          final state = data.popularMoviesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return MovieList(data.popularMovies);
          } else {
            return Text('Failed');
          }
        }),
        _buildSubHeading(
          title: 'Top Rated',
          onTap: () =>
              Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
        ),
        Consumer<MovieListNotifier>(builder: (context, data, child) {
          final state = data.topRatedMoviesState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return MovieList(data.topRatedMovies);
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
