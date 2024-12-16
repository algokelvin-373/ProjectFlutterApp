import 'dart:ffi';

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
}
