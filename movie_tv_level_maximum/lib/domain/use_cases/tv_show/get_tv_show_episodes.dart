import 'package:dartz/dartz.dart';
import 'package:movie_tv_level_maximum/common/failure.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_episode.dart';
import 'package:movie_tv_level_maximum/domain/repositories/tv_show_repository.dart';

class GetTvShowEpisodes {
  final TvShowRepository repository;

  GetTvShowEpisodes(this.repository);

  Future<Either<Failure, TvShowEpisode>> execute(int id, int season) {
    return repository.getAllEpisodes(id, season);
  }
}