import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movie_tv_level_maximum/data/data_sources/db/database_helper.dart';
import 'package:movie_tv_level_maximum/data/data_sources/movie_local_data_source.dart';
import 'package:movie_tv_level_maximum/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_tv_level_maximum/domain/repositories/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
