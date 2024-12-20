import 'package:movie_tv_level_maximum/data/data_sources/db/database_helper.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_table.dart';

import '../../../common/exception.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertWatchlistTvShow(TvShowTable tvShow);
  Future<String> removeWatchlistTvShow(TvShowTable tvShow);
  Future<List<TvShowTable>> getWatchlistTvShow();
  Future<TvShowTable?> getTvShowById(int id);
}

class TvShowLocalDataSourceImpl implements TvShowLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<TvShowTable>> getWatchlistTvShow() async {
    final result = await databaseHelper.getWatchlistTvShows();
    return result.map((data) => TvShowTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlistTvShow(TvShowTable tvShow) async {
    try {
      await databaseHelper.insertWatchlistTvShow(tvShow);
      return 'Added to Watchlist Tv Show';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTvShow(TvShowTable tvShow) async {
    try {
      await databaseHelper.removeWatchlistTvShow(tvShow);
      return 'Removed from Watchlist TV Show';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);
    if (result != null) {
      return TvShowTable.fromMap(result);
    } else {
      return null;
    }
  }
}
