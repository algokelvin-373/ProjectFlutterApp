import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_tv_level_maximum/data/models/genre_model.dart';

import '../../../json_reader.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'name');

  group('Genre Model fromJson', () {
    test('Should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/genre_model.json'));
      final result = GenreModel.fromJson(jsonMap);
      expect(result, tGenreModel);
    });
  });

  group('Genre Model toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tGenreModel.toJson();
      final expectedJsonMap = {
        'id': 1,
        'name': 'name'
      };
      expect(result, expectedJsonMap);
    });
  });
}
