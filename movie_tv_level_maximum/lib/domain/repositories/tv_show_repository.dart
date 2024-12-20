import 'package:dartz/dartz.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_detail.dart';

import '../../common/failure.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getAiringTodayTvShow();
  Future<Either<Failure, List<TvShow>>> getOnTheAirTvShow();
  Future<Either<Failure, List<TvShow>>> getPopularTvShow();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShow();
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
  //Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  //Future<Either<Failure, List<Movie>>> searchMovies(String query);
  //Future<Either<Failure, String>> saveWatchlist(MovieDetail movie);
  //Future<Either<Failure, String>> removeWatchlist(MovieDetail movie);
  //Future<bool> isAddedToWatchlist(int id);
  //Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}