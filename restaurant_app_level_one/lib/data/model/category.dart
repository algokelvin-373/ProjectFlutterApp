class Category {
  String name;

  Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}