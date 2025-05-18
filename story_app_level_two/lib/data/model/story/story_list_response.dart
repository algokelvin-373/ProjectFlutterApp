import 'package:json_annotation/json_annotation.dart';

import 'story.dart';

part 'story_list_response.g.dart';

@JsonSerializable()
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
      _$StoryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryListResponseToJson(this);
}
