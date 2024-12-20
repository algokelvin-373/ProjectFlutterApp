import 'package:equatable/equatable.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show.dart';
import 'package:movie_tv_level_maximum/domain/entities/tv_show/tv_show_detail.dart';

class TvShowTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvShowTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvShowTable.fromEntity(TvShowDetail tvShow) => TvShowTable(
        id: tvShow.id,
        name: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
      );

  factory TvShowTable.fromMap(Map<String, dynamic> map) => TvShowTable(
        id: map['id'],
        name: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];

  TvShow toEntity() {
    return TvShow.simple(
      id: id,
      name: name!,
      posterPath: posterPath!,
      overview: overview!,
    );
  }
}
