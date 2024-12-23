import 'package:movie_tv_level_maximum/data/models/movie/movie_table.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_table.dart';
import 'package:movie_tv_level_maximum/domain/entities/movie/genre.dart';
import 'package:movie_tv_level_maximum/domain/entities/movie/movie.dart';
import 'package:movie_tv_level_maximum/domain/entities/movie/movie_detail.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_detail.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_episode.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovie2 = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
  'overview',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTvShow = TvShow(
  adult: false,
  backdropPath: "backdropPath",
  firstAirDate: DateTime.parse('2024-12-31'),
  id: 1,
  name: "name",
  originCountry: [],
  originalLanguage: "originalLanguage",
  originalName: "originalName",
  overview: "overview",
  popularity: 1.0,
  posterPath: "posterPath",
  voteAverage: 1,
  voteCount: 1,
  genreIds: [],
);

final testMovieList = [testMovie];

final testTvShowList = [testTvShow];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvShowDetail = TvShowDetail(
  adult: false,
  backdropPath: "backdropPath",
  episodeRunTime: [],
  firstAirDate: DateTime.parse('2024-12-31'),
  genres: [],
  homepage: "homepage",
  id: 1,
  inProduction: false,
  languages: [],
  lastAirDate: DateTime.parse('2024-12-31'),
  name: "name",
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: [],
  originalLanguage: "originalLanguage",
  originalName: "originalName",
  overview: "overview",
  popularity: 1,
  posterPath: "posterPath",
  seasons: [],
  status: "status",
  tagline: "tagline",
  type: "type",
  voteAverage: 1,
  voteCount: 1,
);

final testTvShowEpisodes = TvShowEpisode(
  id: "1",
  airDate: DateTime.parse('2024-12-31'),
  episodes: [],
  name: "name",
  overview: "overview",
  tvShowEpisodeResponseId: 1,
  posterPath: "posterPath",
  seasonNumber: 1,
  voteAverage: 1.0,
);

final testTvShowEpisodes2 = TvShowEpisode(
  id: "2",
  airDate: DateTime.parse('2024-12-31'),
  episodes: [],
  name: "name",
  overview: "overview",
  tvShowEpisodeResponseId: 1,
  posterPath: "posterPath",
  seasonNumber: 1,
  voteAverage: 1.0,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTvShow = TvShow.simple(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvShowTable = TvShowTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvShowMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
