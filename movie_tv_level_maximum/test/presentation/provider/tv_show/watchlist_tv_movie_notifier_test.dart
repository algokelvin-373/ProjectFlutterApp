import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/failure.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_watchlist_tv_shows.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/watchlist_tv_show_notifier.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_movie_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShows])
void main() {
  late WatchlistTvShowNotifier provider;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    provider = WatchlistTvShowNotifier(
      getWatchlistTvShows: mockGetWatchlistTvShows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Watchlist TV Show', () {
    test('Should change tv shows data when data is gotten successfully',
        () async {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right([testWatchlistTvShow]));
      await provider.fetchWatchlistTvShows();
      expect(provider.watchlistState, RequestState.Loaded);
      expect(provider.watchlistTvShows, [testWatchlistTvShow]);
      expect(listenerCallCount, 2);
    });

    test('Should return error when data is unsuccessful', () async {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      await provider.fetchWatchlistTvShows();
      expect(provider.watchlistState, RequestState.Error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });
}
