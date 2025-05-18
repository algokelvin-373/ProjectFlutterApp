import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/movie/movie.dart';
import 'package:movie_tv_level_maximum/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:movie_tv_level_maximum/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesNotifier])
void main() {
  late MockTopRatedMoviesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedMoviesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
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

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Top Rated Movies'), findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('fetchTopRatedMovies should be called when page is initialized',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(<Movie>[]);
    when(mockNotifier.fetchTopRatedMovies()).thenAnswer((_) async {});
    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));
    verify(mockNotifier.fetchTopRatedMovies()).called(1);
  });

  testWidgets('ListView should display correct number of movies',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(tListMovie);

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(find.byType(MovieCard), findsNWidgets(2));
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
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

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(find.text('No movies available'), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
