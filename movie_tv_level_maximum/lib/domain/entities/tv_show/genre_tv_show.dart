import 'package:equatable/equatable.dart';

class GenreTvShow extends Equatable {
  const GenreTvShow({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
