import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/presentation/pages/tv_show/tv_show_detail_body_page.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_body_page.mocks.dart';

@GenerateMocks([TvShowDetailNotifier])
void main() {
  late MockTvShowDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvShowDetailNotifier();
  });

  Widget _createTestableWidget(Widget child) {
    return ChangeNotifierProvider<TvShowDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  final testRecommendations = [testTvShow, testTvShow2];

  group('TVShowDetailBodyPage Widget Test', () {
    testWidgets('Should display TV show details properly',
        (WidgetTester tester) async {
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvShowRecommendations).thenReturn(testRecommendations);

      await tester.pumpWidget(
        _createTestableWidget(
          TvShowDetailBodyPage(
            tvShow: testTvShowDetail,
            recommendations: testRecommendations,
            isAddedWatchlist: false,
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsWidgets);
      expect(find.text('name'), findsOneWidget);
      expect(find.text('overview'), findsOneWidget);
    });

    testWidgets('Should pop when back button is pressed',
        (WidgetTester tester) async {
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvShowRecommendations).thenReturn(testRecommendations);

      await tester.pumpWidget(
        _createTestableWidget(
          TvShowDetailBodyPage(
            tvShow: testTvShowDetail,
            recommendations: testRecommendations,
            isAddedWatchlist: false,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.text('name'), findsNothing);
    });
  });
}
