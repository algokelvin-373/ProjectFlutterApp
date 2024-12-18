import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movie_tv_level_maximum/data/data_sources/tv_show/tv_show_remote_data_source.dart';
import 'package:movie_tv_level_maximum/data/repositories/tv_show_repository_impl.dart';
import 'package:movie_tv_level_maximum/domain/repositories/tv_show_repository.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_airing_today.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_on_the_air.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_popular.dart';
import 'package:movie_tv_level_maximum/domain/use_cases/tv_show/get_tv_show_top_rated.dart';
import 'package:movie_tv_level_maximum/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/provider/movie_list_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/provider/movie_search_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/provider/popular_movies_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/provider/tv_show/tv_show_list_notifier.dart';
import 'package:movie_tv_level_maximum/presentation/provider/watchlist_movie_notifier.dart';

import 'data/data_sources/db/database_helper.dart';
import 'data/data_sources/movie_local_data_source.dart';
import 'data/data_sources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/use_cases/get_movie_detail.dart';
import 'domain/use_cases/get_movie_recommendations.dart';
import 'domain/use_cases/get_now_playing_movies.dart';
import 'domain/use_cases/get_popular_movies.dart';
import 'domain/use_cases/get_top_rated_movies.dart';
import 'domain/use_cases/get_watchlist_movies.dart';
import 'domain/use_cases/get_watchlist_status.dart';
import 'domain/use_cases/remove_watchlist.dart';
import 'domain/use_cases/save_watchlist.dart';
import 'domain/use_cases/search_movies.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowListNotifier(
      getAiringTodayTvShow: locator(),
      getOnTheAirTvShow: locator(),
      getPopularTvShow: locator(),
      getTopRatedTvShow: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetAiringTodayTvShow(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTvShow(locator()));
  locator.registerLazySingleton(() => GetPopularTvShow(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShow(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvShowRepository>(
      () => TvShowRepositoryImpl(remoteDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
