import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/remove_watchlist_tv_show.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'get_list_tv_shows_test.mocks.dart';

void main() {
  late RemoveWatchlistTvShow useCase;
  late MockTvShowRepository repository;

  setUp(() {
    repository = MockTvShowRepository();
    useCase = RemoveWatchlistTvShow(repository);
  });

  test('Should remove watchlist tv show from repository', () async {
    when(repository.removeWatchlistTvShow(testTvShowDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    final result = await useCase.execute(testTvShowDetail);
    verify(repository.removeWatchlistTvShow(testTvShowDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
