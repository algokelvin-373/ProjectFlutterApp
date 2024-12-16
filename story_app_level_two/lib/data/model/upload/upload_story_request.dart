import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'upload_story_request.g.dart';

@JsonSerializable()
class UploadStoryRequest {
  List<int> bytes;
  String fileName;
  String description;
  double? lat;
  double? lng;

  UploadStoryRequest({
    required this.bytes,
    required this.fileName,
    required this.description,
    this.lat,
    this.lng,
  });

  factory UploadStoryRequest.fromJson(Map<String, dynamic> json) => _$UploadStoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadStoryRequestToJson(this);
}
