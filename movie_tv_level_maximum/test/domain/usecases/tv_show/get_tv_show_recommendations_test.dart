import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_recommendations.dart';

import 'get_list_tv_shows_test.mocks.dart';

void main() {
  late GetTvShowRecommendations useCase;
  late MockTvShowRepository repository;

  setUp(() {
    repository = MockTvShowRepository();
    useCase = GetTvShowRecommendations(repository);
  });

  final tId = 1;
  final tTvShows = <TvShow>[];

  test('Should get list of tv show recommendations from the repository',
      () async {
    when(repository.getTvShowRecommendations(tId))
        .thenAnswer((_) async => Right(tTvShows));
    final result = await useCase.execute(tId);
    expect(result, Right(tTvShows));
  });
}
