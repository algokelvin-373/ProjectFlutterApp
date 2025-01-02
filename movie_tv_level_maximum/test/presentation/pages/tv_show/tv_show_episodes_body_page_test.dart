import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/episode_tv_show.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_episode.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/tv_show_episodes_body_page.dart';

void main() {
  final tTvShowEpisode = TvShowEpisode(
    id: "1",
    airDate: DateTime.parse('2024-12-31'),
    episodes: [
      EpisodeTvShow(
        airDate: DateTime.parse('2024-12-31'),
        episodeNumber: 1,
        episodeType: "1",
        id: 1,
        name: "name ep 1",
        overview: "overview ep 1",
        productionCode: "productionCode",
        runtime: 1,
        seasonNumber: 1,
        showId: 1,
        stillPath: "stillPath",
        voteAverage: 1.0,
        voteCount: 1,
      ),
      EpisodeTvShow(
        airDate: DateTime.parse('2024-12-31'),
        episodeNumber: 1,
        episodeType: "1",
        id: 2,
        name: "name ep 2",
        overview: "overview ep 2",
        productionCode: "productionCode",
        runtime: 1,
        seasonNumber: 1,
        showId: 1,
        stillPath: "stillPath",
        voteAverage: 1.0,
        voteCount: 1,
      )
    ],
    name: "name",
    overview: "overview",
    tvShowEpisodeResponseId: 1,
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  final tTvShowEpisodeEmptyOverview = TvShowEpisode(
    id: "1",
    airDate: DateTime.parse('2024-12-31'),
    episodes: [],
    name: "name",
    overview: "",
    tvShowEpisodeResponseId: 1,
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  testWidgets('Should display all element properly in TvShowEpisodesBodyPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TvShowEpisodesBodyPage(
          tvShowEpisodes: tTvShowEpisode,
        ),
      ),
    );

    expect(find.byType(CachedNetworkImage), findsNWidgets(3));
    expect(find.text('name'), findsOneWidget); // Name is shown
    expect(find.text('overview'), findsOneWidget); // Overview is shown
    expect(find.text('1 - name ep 1'), findsOneWidget);
    expect(find.text('overview ep 1'), findsOneWidget);
    //expect(find.text('2 - name ep 2'), findsOneWidget);
    expect(find.text('overview ep 2'), findsOneWidget);
  });

  testWidgets('Should show default text when overview is empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TvShowEpisodesBodyPage(
          tvShowEpisodes: tTvShowEpisodeEmptyOverview,
        ),
      ),
    );
    expect(find.text('Nothing Overview'), findsOneWidget);
  });

  testWidgets('Should pop when back button is pressed', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TvShowEpisodesBodyPage(
          tvShowEpisodes: tTvShowEpisodeEmptyOverview,
        ),
      ),
    );
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('name'), findsNothing);
  });
}
