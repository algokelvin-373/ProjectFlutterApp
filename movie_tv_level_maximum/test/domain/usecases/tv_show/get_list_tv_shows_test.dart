import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/repositories/tv_show_repository.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_on_the_air.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_popular.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_top_rated.dart';

import 'get_list_tv_shows_test.mocks.dart';

@GenerateMocks([TvShowRepository])
void main() {
  late GetPopularTvShow useCaseGetPopular;
  late GetTopRatedTvShow useCaseGetTopRated;
  late GetOnTheAirTvShow useCaseGetOnTheAir;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCaseGetPopular = GetPopularTvShow(mockTvShowRepository);
    useCaseGetTopRated = GetTopRatedTvShow(mockTvShowRepository);
    useCaseGetOnTheAir = GetOnTheAirTvShow(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];

  group('GetPopularTvShows Tests', () {
    group('execute', () {
      test(
          'Should get list of tv shows from the repository when execute function is called',
          () async {
        when(mockTvShowRepository.getPopularTvShow())
            .thenAnswer((_) async => Right(tTvShows));
        final result = await useCaseGetPopular.execute();
        expect(result, Right(tTvShows));
      });
    });
  });

  group('GetTopRatedTvShows Tests', () {
    group('execute', () {
      test(
          'Should get list of tv shows from the repository when execute function is called',
          () async {
        when(mockTvShowRepository.getTopRatedTvShow())
            .thenAnswer((_) async => Right(tTvShows));
        final result = await useCaseGetTopRated.execute();
        expect(result, Right(tTvShows));
      });
    });
  });

  group('GetOnTheAirTvShows Tests', () {
    group('execute', () {
      test(
          'Should get list of tv shows from the repository when execute function is called',
          () async {
        when(mockTvShowRepository.getOnTheAirTvShow())
            .thenAnswer((_) async => Right(tTvShows));
        final result = await useCaseGetOnTheAir.execute();
        expect(result, Right(tTvShows));
      });
    });
  });
}
