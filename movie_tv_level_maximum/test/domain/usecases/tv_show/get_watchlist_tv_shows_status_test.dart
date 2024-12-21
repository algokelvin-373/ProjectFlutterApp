import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/get_watchlist_status.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_watchlist_tv_show_status.dart';

import '../../../helpers/test_helper.mocks.dart';
import 'get_list_tv_shows_test.mocks.dart';

void main() {
  late GetWatchListTvShowStatus useCase;
  late MockTvShowRepository repository;

  setUp(() {
    repository = MockTvShowRepository();
    useCase = GetWatchListTvShowStatus(repository);
  });

  test('Should get watchlist status from repository', () async {
    when(repository.isAddedToWatchlistTvShow(1))
        .thenAnswer((_) async => true);
    final result = await useCase.execute(1);
    expect(result, true);
  });
}
