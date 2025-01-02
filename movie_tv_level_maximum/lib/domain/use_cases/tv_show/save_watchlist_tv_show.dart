import 'package:dartz/dartz.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_detail.dart';
import 'package:movie_tv_level_maximum/domain/repositories/tv_show_repository.dart';

import '../../../common/failure.dart';

class SaveWatchlistTvShow {
  final TvShowRepository repository;

  SaveWatchlistTvShow(this.repository);

  Future<Either<Failure, String>> execute(TvShowDetail tvShow) {
    return repository.saveWatchlistTvShow(tvShow);
  }
}
