import 'package:json_annotation/json_annotation.dart';

part 'upload_story_response.g.dart';

@JsonSerializable()
class UploadStoryResponse {
  bool error;
  String message;

  UploadStoryResponse({required this.error, required this.message});

  factory UploadStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadStoryResponseToJson(this);
}
