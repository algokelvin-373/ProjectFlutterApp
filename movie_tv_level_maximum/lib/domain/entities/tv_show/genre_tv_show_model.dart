import 'package:equatable/equatable.dart';

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  // Genre toEntity() {
  //   return Genre(id: id, name: name);
  // }

  @override
  List<Object?> get props => [id, name];
}
