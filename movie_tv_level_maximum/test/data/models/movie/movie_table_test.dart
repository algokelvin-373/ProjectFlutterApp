import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/data/models/movie/movie_table.dart';

void main() {
  final tMovieTable = MovieTable(
    id: 1,
    title: "title",
    posterPath: "posterPath",
    overview: "overview",
  );

  group('Movie Table toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tMovieTable.toJson();
      final expectedJsonMap = {
        "id": 1,
        "title": "title",
        "posterPath": "posterPath",
        "overview": "overview",
      };
      expect(result, expectedJsonMap);
    });
  });
}
