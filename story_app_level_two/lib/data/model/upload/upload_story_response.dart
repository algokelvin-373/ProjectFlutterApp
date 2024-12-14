import 'dart:convert';

class UploadStoryResponse {
  bool error;
  String message;

  UploadStoryResponse({
    required this.error,
    required this.message,
  });

  factory UploadStoryResponse.fromMap(Map<String, dynamic> map) {
    return UploadStoryResponse(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }

  factory UploadStoryResponse.fromJson(String source) =>
      UploadStoryResponse.fromMap(json.decode(source));
}
