import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_episode.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/tv_show_episodes_body_page.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/tv_show_episodes_page.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_episodes_notifier.dart';
import 'package:provider/provider.dart';

import 'tv_show_episodes_page_test.mocks.dart';

@GenerateMocks([TvShowEpisodesNotifier])
void main() {
  late MockTvShowEpisodesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvShowEpisodesNotifier();
  });

  Widget createWidgetUnderTest() {
    return ChangeNotifierProvider<TvShowEpisodesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: TvShowEpisodesPage(id: 1, season: 1),
      ),
    );
  }

  final tvShowEpisode1 = TvShowEpisode(
    id: "1",
    airDate: DateTime.parse('2024-12-31'),
    episodes: [],
    name: "name",
    overview: "overview",
    tvShowEpisodeResponseId: 1,
    posterPath: "posterPath",
    seasonNumber: 1,
    voteAverage: 1.0,
  );

  testWidgets('Should display CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowEpisodeState).thenReturn(RequestState.Loading);
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should display tv show episodes when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowEpisodeState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowEpisode).thenReturn(tvShowEpisode1);

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(TvShowEpisodesBodyPage), findsOneWidget);
  });

  testWidgets('Should display error message when data is Error',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowEpisodeState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error occurred');

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Error occurred'), findsOneWidget);
  });
}
