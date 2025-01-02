import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/common/failure.dart';
import 'package:movie_tv_level_maximum/common/state_enum.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_top_rated.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/top_rated_tv_shows_notifier.dart';

import 'top_rated_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShow])
void main() {
  late MockGetTopRatedTvShow mockGetTopRatedTvShow;
  late TopRatedTvShowsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvShow = MockGetTopRatedTvShow();
    notifier = TopRatedTvShowsNotifier(
      getTopRatedTvShow: mockGetTopRatedTvShow,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvShow = TvShow(
    adult: false,
    backdropPath: "backdropPath",
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['', ''],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.1,
    posterPath: "posterPath",
    firstAirDate: DateTime.parse('2024-12-31'),
    name: "name",
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowList = <TvShow>[tTvShow];

  group('Popular TV Shows Page', () {
    test('Should change state to loading when use case is called', () async {
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      notifier.fetchTopRatedTvShows();
      expect(notifier.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('Should change tv shows data when data is gotten successfully',
        () async {
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      await notifier.fetchTopRatedTvShows();
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.tvShows, tTvShowList);
      expect(listenerCallCount, 2);
    });

    test('Should return error when data is unsuccessful', () async {
      when(mockGetTopRatedTvShow.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      await notifier.fetchTopRatedTvShows();
      expect(notifier.state, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
