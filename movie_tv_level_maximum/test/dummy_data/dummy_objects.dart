import 'package:movie_tv_level_maximum/data/models/genre_model.dart';
import 'package:movie_tv_level_maximum/data/models/movie_table.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_table.dart';
import 'package:movie_tv_level_maximum/domain/entities/genre.dart';
import 'package:movie_tv_level_maximum/domain/entities/movie.dart';
import 'package:movie_tv_level_maximum/domain/entities/movie_detail.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_detail.dart';

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

final testMovieList = [testMovie];

/*final testTvShowDetail = TvShowDetail(
    adult: false,
    backdropPath: "backdropPath",
    episodeRunTime: [],
    firstAirDate: DateTime.parse('2024-12-31'),
    genres: [GenreModel(id: 1, name: 'Action')],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: ['', ''],
    lastAirDate: DateTime.parse('2024-12-31'),
    name: "name",
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: [],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 1.0,
    posterPath: "posterPath",
    seasons: [],
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 1,
    voteCount: 1,
);*/

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
  'title': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};