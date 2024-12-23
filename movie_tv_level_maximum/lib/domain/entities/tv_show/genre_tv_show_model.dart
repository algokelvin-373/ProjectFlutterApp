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

  @override
  List<Object?> get props => [id, name];
}
