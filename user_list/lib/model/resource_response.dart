import 'package:mobile_flutter/model/resource.dart';

class ResourceResponse {
  final List<Resource> resources;

  ResourceResponse({
    required this.resources,
  });

  factory ResourceResponse.fromJson(Map<String, dynamic> json) {
    var resourceList = (json['data'] as List)
        .map((resource) => Resource.fromJson(resource))
        .toList();

    return ResourceResponse(
      resources: resourceList,
    );
  }
}