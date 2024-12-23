import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/on_the_air_tv_shows_page.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/on_the_air_tv_shows_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/widgets/tv_show_card_list.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_shows_page_test.mocks.dart';

@GenerateMocks([OnTheAirTvShowsNotifier])
void main() {
  late MockOnTheAirTvShowsNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockOnTheAirTvShowsNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<OnTheAirTvShowsNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tListTvShow = [testTvShow, testTvShow2];

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(OnTheAirTvShowsPage()));
    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShows).thenReturn(<TvShow>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(OnTheAirTvShowsPage()));
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('fetchOnTheAirTvShows should be called when page is initialized',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShows).thenReturn(<TvShow>[]);
    when(mockNotifier.fetchOnTheAirTvShows()).thenAnswer((_) async {});
    await tester.pumpWidget(makeTestableWidget(OnTheAirTvShowsPage()));
    verify(mockNotifier.fetchOnTheAirTvShows()).called(1);
  });

  testWidgets('TvShowCard should display tv show details correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvShowCard(testTvShow),
        ),
      ),
    );

    expect(find.text('name'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('ListView should display correct number of tv shows',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShows).thenReturn(tListTvShow);

    await tester.pumpWidget(makeTestableWidget(OnTheAirTvShowsPage()));

    expect(find.byType(TvShowCard), findsNWidgets(2));
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(OnTheAirTvShowsPage()));
    expect(textFinder, findsOneWidget);
  });
}
