import 'package:equatable/equatable.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/genre_tv_show.dart';

class GenreTvShowModel extends Equatable {
  const GenreTvShowModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreTvShowModel.fromJson(Map<String, dynamic> json) =>
      GenreTvShowModel(
        id: json["id"],
        name: json["name"],
      );

  GenreTvShow toEntity() {
    return GenreTvShow(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, name];
}
