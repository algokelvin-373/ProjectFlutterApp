import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/data/models/tv_show/tv_show_table.dart';

void main() {
  final tTvShowTable = TvShowTable(
    id: 1,
    name: "name",
    posterPath: "posterPath",
    overview: "overview",
  );

  group('TV Show Table toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvShowTable.toJson();
      final expectedJsonMap = {
        "id": 1,
        "name": "name",
        "posterPath": "posterPath",
        "overview": "overview",
      };
      expect(result, expectedJsonMap);
    });
  });
}
