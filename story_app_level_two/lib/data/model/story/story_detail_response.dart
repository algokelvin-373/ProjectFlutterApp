import 'package:json_annotation/json_annotation.dart';

import 'story.dart';

part 'story_detail_response.g.dart';

@JsonSerializable()
class StoryDetailResponse {
  bool error;
  String message;
  Story? story;

  StoryDetailResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  factory StoryDetailResponse.fromJson(Map<String, dynamic> json) => _$StoryDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryDetailResponseToJson(this);
}
