import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/tv_show_detail_page.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_page_test.mocks.dart';

@GenerateMocks([TvShowDetailNotifier])
void main() {
  late MockTvShowDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvShowDetailNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvShowDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Should display center when loading get data TV Show Detail',
      (WidgetTester tester) async {
    final tId = 1;
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TvShowDetailPage(id: tId)));
    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlistTvShow).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(TvShowDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlistTvShow).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(TvShowDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display SnackBar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlistTvShow).thenReturn(false);
    when(mockNotifier.watchlistTvShowMessage)
        .thenReturn('Added to Watchlist TV Show');

    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(makeTestableWidget(TvShowDetailPage(id: 1)));
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist TV Show'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.tvShowState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShow).thenReturn(testTvShowDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
    when(mockNotifier.isAddedToWatchlistTvShow).thenReturn(false);
    when(mockNotifier.watchlistTvShowMessage).thenReturn('Failed');

    final watchlistButton = find.byType(FilledButton);

    await tester.pumpWidget(makeTestableWidget(TvShowDetailPage(id: 1)));
    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
