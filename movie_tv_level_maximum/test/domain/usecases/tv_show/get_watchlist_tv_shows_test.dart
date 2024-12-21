import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_watchlist_tv_shows.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'get_list_tv_shows_test.mocks.dart';

void main() {
  late GetWatchlistTvShows useCase;
  late MockTvShowRepository repository;

  setUp(() {
    repository = MockTvShowRepository();
    useCase = GetWatchlistTvShows(repository);
  });

  test('should get list of movies from the repository', () async {
    when(repository.getWatchlistTvShow())
        .thenAnswer((_) async => Right(testTvShowList));
    final result = await useCase.execute();
    expect(result, Right(testTvShowList));
  });
}
