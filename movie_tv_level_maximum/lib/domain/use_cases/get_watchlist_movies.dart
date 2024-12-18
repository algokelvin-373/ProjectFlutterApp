import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
