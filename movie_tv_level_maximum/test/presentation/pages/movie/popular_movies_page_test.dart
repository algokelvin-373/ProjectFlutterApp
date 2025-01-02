import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/movie/movie.dart';
import 'package:movie_tv_level_maximum/presentation/pages/movie/popular_movies_page.dart';
import 'package:movie_tv_level_maximum/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesNotifier])
void main() {
  late MockPopularMoviesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularMoviesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularMoviesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tListMovie = [testMovie, testMovie2];

  testWidgets('Page should display AppBar with correct title',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Popular Movies'), findsOneWidget);
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('fetchPopularMovies should be called when page is initialized',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(<Movie>[]);
    when(mockNotifier.fetchPopularMovies()).thenAnswer((_) async {});
    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));
    verify(mockNotifier.fetchPopularMovies()).called(1);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('ListView should display correct number of movies',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(tListMovie);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(MovieCard), findsNWidgets(2));
  });

  testWidgets('MovieCard should display movie details correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieCard(testMovie2),
        ),
      ),
    );

    expect(find.text('Spider-Man'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('Page should display text when there are no movies',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Empty);
    when(mockNotifier.message).thenReturn('No movies available');

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(find.text('No movies available'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
