// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadStoryResponse _$UploadStoryResponseFromJson(Map<String, dynamic> json) =>
    UploadStoryResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UploadStoryResponseToJson(
        UploadStoryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
