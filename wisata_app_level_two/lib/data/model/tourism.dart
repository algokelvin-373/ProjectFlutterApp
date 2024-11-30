class Tourism {
  int id;
  String name;
  String description;
  String address;
  double longitude;
  double latitude;
  int like;
  String image;

  Tourism({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.like,
    required this.image,
  });

  factory Tourism.fromJson(Map<String, dynamic> json) => Tourism(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    address: json["address"],
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    like: json["like"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "like": like,
    "image": image,
  };
}