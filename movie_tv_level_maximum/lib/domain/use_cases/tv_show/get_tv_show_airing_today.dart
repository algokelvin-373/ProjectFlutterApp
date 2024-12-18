import 'package:dartz/dartz.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/repositories/tv_show_repository.dart';

import '../../../common/failure.dart';

class GetAiringTodayTvShow {
  final TvShowRepository repository;

  GetAiringTodayTvShow(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getAiringTodayTvShow();
  }
}
