import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_detail.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'get_list_tv_shows_test.mocks.dart';

void main() {
  late GetTvShowDetail useCase;
  late MockTvShowRepository repository;

  setUp(() {
    repository = MockTvShowRepository();
    useCase = GetTvShowDetail(repository);
  });

  final tId = 1;

  test('Should get tv show detail from the repository', () async {
    when(repository.getTvShowDetail(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    final result = await useCase.execute(tId);
    expect(result, Right(testTvShowDetail));
  });
}
