import 'story.dart';

class StoryListResponse {
  bool error;
  String message;
  List<Story> listStory;

  StoryListResponse({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoryListResponse.fromJson(Map<String, dynamic> json) =>
      StoryListResponse(
        error: json["error"],
        message: json["message"],
        listStory: List<Story>.from(
          json["listStory"].map((x) => Story.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": List<dynamic>.from(listStory.map((x) => x.toJson())),
      };
}
