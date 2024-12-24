import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_episodes.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'get_list_tv_shows_test.mocks.dart';

void main() {
  late GetTvShowEpisodes useCase;
  late MockTvShowRepository repository;

  setUp(() {
    repository = MockTvShowRepository();
    useCase = GetTvShowEpisodes(repository);
  });

  final tId = 1;
  final tSeason = 1;

  test('Should get tv show episodes from the repository', () async {
    when(repository.getAllEpisodes(tId, tSeason))
        .thenAnswer((_) async => Right(testTvShowEpisodes));
    final result = await useCase.execute(tId, tSeason);
    expect(result, Right(testTvShowEpisodes));
  });
}
