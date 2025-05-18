import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:story_app_level_two/data/api/api_services.dart';
import 'package:story_app_level_two/data/model/upload/upload_story_request.dart';
import 'package:story_app_level_two/data/model/upload/upload_story_response.dart';

import '../../db/auth_repository.dart';

class UploadProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiServices apiServices;

  UploadProvider(this.apiServices, this.authRepository);

  bool isUploading = false;
  String message = "";
  String imagePath = "";
  XFile? imageFile;
  UploadStoryResponse? uploadStoryResponse;

  void setImagePath(String value) {
    imagePath = value;
    notifyListeners();
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  void setIsUploading(bool value) {
    isUploading = value;
    notifyListeners();
  }

  Future<void> upload(
    List<int> bytes,
    String fileName,
    String description, [
    double? lat,
    double? lng,
  ]) async {
    try {
      message = "";
      uploadStoryResponse = null;
      notifyListeners();

      UploadStoryRequest request;
      if (lat == null && lng == null) {
        request = UploadStoryRequest(
          bytes: bytes,
          fileName: fileName,
          description: description,
        );
      } else {
        // With lat and lng for location map
        request = UploadStoryRequest(
          bytes: bytes,
          fileName: fileName,
          description: description,
          lat: lat,
          lng: lng,
        );
      }
      String token = await authRepository.getToken();
      uploadStoryResponse = await apiServices.uploadStory(token, request);

      message = uploadStoryResponse?.message ?? "Success Upload Story";
      isUploading = false;
      notifyListeners();
    } catch (e) {
      isUploading = false;
      message = e.toString();
      notifyListeners();
    }
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(bytes)!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];

    do {
      compressQuality -= 10;
      newByte = img.encodeJpg(image, quality: compressQuality);
      length = newByte.length;
    } while (length > 1000000);

    return newByte;
  }

  Future<List<int>> resizeImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;

    final img.Image image = img.decodeImage(bytes)!;
    bool isWidthMoreTaller = image.width > image.height;
    int imageTall = isWidthMoreTaller ? image.width : image.height;
    double compressTall = 1;
    int length = imageLength;
    List<int> newByte = bytes;

    do {
      compressTall -= 0.1;
      final newImage = img.copyResize(
        image,
        width: isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
        height: !isWidthMoreTaller ? (imageTall * compressTall).toInt() : null,
      );

      length = newImage.length;
      if (length < 1000000) {
        newByte = img.encodeJpg(newImage);
      }
    } while (length > 1000000);

    return newByte;
  }
}
