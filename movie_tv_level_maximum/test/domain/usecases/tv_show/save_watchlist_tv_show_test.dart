import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/save_watchlist_tv_show.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'get_list_tv_shows_test.mocks.dart';

void main() {
  late SaveWatchlistTvShow useCase;
  late MockTvShowRepository repository;

  setUp(() {
    repository = MockTvShowRepository();
    useCase = SaveWatchlistTvShow(repository);
  });

  test('Should save tv show to the repository', () async {
    when(repository.saveWatchlistTvShow(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist Tv Show'));
    final result = await useCase.execute(testTvShowDetail);
    verify(repository.saveWatchlistTvShow(testTvShowDetail));
    expect(result, Right('Added to Watchlist Tv Show'));
  });
}
