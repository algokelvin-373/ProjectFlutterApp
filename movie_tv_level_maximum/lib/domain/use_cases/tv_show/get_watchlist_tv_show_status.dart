import 'package:movie_tv_level_maximum/domain/repositories/tv_show_repository.dart';

class GetWatchListTvShowStatus {
  final TvShowRepository repository;

  GetWatchListTvShowStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlistTvShow(id);
  }
}
