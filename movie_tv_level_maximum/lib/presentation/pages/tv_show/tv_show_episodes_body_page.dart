import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/episode_tv_show.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_episode.dart';

import '../../../common/constants.dart';

class TvShowEpisodesBodyPage extends StatelessWidget {
  final TvShowEpisode tvShowEpisodes;

  const TvShowEpisodesBodyPage({
    super.key,
    required this.tvShowEpisodes,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvShowEpisodes.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return _actionTvShowEpisodes(scrollController, context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _actionTvShowEpisodes(
      ScrollController scrollController, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kRichBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.only(
        left: 16,
        top: 16,
        right: 16,
      ),
      //child: CircularProgressIndicator(),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tvShowEpisodes.name,
                    style: kHeading5,
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: tvShowEpisodes.voteAverage / 2,
                        itemCount: 5,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: kMikadoYellow,
                        ),
                        itemSize: 24,
                      ),
                      Text('${tvShowEpisodes.voteAverage}')
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Overview',
                    style: kHeading6,
                  ),
                  Text(
                    tvShowEpisodes.overview.isNotEmpty
                        ? tvShowEpisodes.overview
                        : 'Nothing Overview',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'All Episodes',
                    style: kHeading6,
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 1,
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 5),
                  _listEpisodes(context, tvShowEpisodes.episodes),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.white,
              height: 4,
              width: 48,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listEpisodes(
      BuildContext context, List<EpisodeTvShow> episodes) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: episodes.length,
        itemBuilder: (context, index) {
          final episode = episodes[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${episode.episodeNumber} - ${episode.name}',
                style: kHeading6,
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: episode.voteAverage / 2,
                    itemCount: 5,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: kMikadoYellow,
                    ),
                    itemSize: 24,
                  ),
                  Text('${episode.voteAverage}')
                ],
              ),
              const SizedBox(height: 10),
              Text('Overview', style: kSubtitle),
              Text(episode.overview, style: kBodyText),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}
