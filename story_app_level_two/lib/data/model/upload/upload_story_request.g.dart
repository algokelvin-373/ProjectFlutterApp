// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_story_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadStoryRequest _$UploadStoryRequestFromJson(Map<String, dynamic> json) =>
    UploadStoryRequest(
      bytes: (json['bytes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      fileName: json['fileName'] as String,
      description: json['description'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UploadStoryRequestToJson(UploadStoryRequest instance) =>
    <String, dynamic>{
      'bytes': instance.bytes,
      'fileName': instance.fileName,
      'description': instance.description,
      'lat': instance.lat,
      'lng': instance.lng,
    };
