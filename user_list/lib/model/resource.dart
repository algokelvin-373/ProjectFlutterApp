class Resource {
  final int id;
  final String name;
  final int year;
  final String color;

  const Resource({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      id: json['id'],
      name: json['name'],
      year: json['year'],
      color: json['color'],
    );
  }
}