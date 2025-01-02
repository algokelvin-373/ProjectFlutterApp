import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/search_tv_shows.dart';

import 'get_list_tv_shows_test.mocks.dart';

void main() {
  late SearchTvShows useCase;
  late MockTvShowRepository repository;

  setUp(() {
    repository = MockTvShowRepository();
    useCase = SearchTvShows(repository);
  });

  final tTvShows = <TvShow>[];
  final tQuery = 'Avatar';

  test('Should get list of tv show from the repository', () async {
    when(repository.searchTvShows(tQuery))
        .thenAnswer((_) async => Right(tTvShows));
    final result = await useCase.execute(tQuery);
    expect(result, Right(tTvShows));
  });
}
