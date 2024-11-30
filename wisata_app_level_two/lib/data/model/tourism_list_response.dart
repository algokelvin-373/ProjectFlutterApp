import 'tourism.dart';

class TourismListResponse {
  bool error;
  String message;
  int count;
  List<Tourism> places;

  TourismListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.places,
  });

  factory TourismListResponse.fromJson(Map<String, dynamic> json) {
    return TourismListResponse(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      places: json["places"] != null
          ? List<Tourism>.from(json["places"]!.map((x) => Tourism.fromJson(x)))
          : <Tourism>[],
    );
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "places": List<dynamic>.from(places.map((x) => x.toJson())),
  };
}