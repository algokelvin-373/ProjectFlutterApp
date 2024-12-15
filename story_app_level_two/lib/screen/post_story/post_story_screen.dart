import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app_level_two/provider/upload/upload_provider.dart';
import 'package:story_app_level_two/utils/global_function.dart';

import '../../provider/home/story_list_provider.dart';

class PostStoryScreen extends StatefulWidget {
  final Function() onPostStory;

  const PostStoryScreen({super.key, required this.onPostStory});

  @override
  State<PostStoryScreen> createState() => _PostStoryScreenState();
}

class _PostStoryScreenState extends State<PostStoryScreen> {
  final descriptionController = TextEditingController();
  final _picker = ImagePicker();

  // For Get Image from Camera
  Future<void> _pickImageFromCamera() async {
    final provider = context.read<UploadProvider>();
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        provider.setImageFile(pickedFile);
        provider.setImagePath(pickedFile.path);
      });
    }
  }

  // For Get Image from Gallery
  Future<void> _pickImageFromGallery() async {
    final provider = context.read<UploadProvider>();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        provider.setImageFile(pickedFile);
        provider.setImagePath(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<UploadProvider>();
    final imgPath = provider.imagePath;
    final imgFile = provider.imageFile;

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Story'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: (imgPath.toString() == '')
                    ? Icon(Icons.image, size: 80, color: Colors.grey)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.file(
                          File(imgPath.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              spaceVertical(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _pickImageFromCamera,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              spaceVertical(20),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              spaceVertical(20),
              context.watch<UploadProvider>().isUploading
                  ? const CircularProgressIndicator()
                  : _uploadStory(imgPath, imgFile, provider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _uploadStory(String imgPath, XFile? imgFile, UploadProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          provider.setIsUploading(true);

          final maxFileSize = 1 * 1024 * 1024;
          final scaffoldMessage = ScaffoldMessenger.of(context);
          final uploadProvider = context.read<UploadProvider>();

          if (imgPath == '' || imgFile == null) {
            scaffoldMessage.showSnackBar(
              SnackBar(
                content: Text(
                  'No image selected. Please choose an image.',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          // Image Processing - (Resize then Compress)
          final fileName = imgFile.path;
          final bytes = await imgFile.readAsBytes();
          final bytesResize = await uploadProvider.resizeImage(bytes);
          final bytesCompress = await uploadProvider.compressImage(bytesResize);

          // Check Size Image Not More Than 1 MB
          final imgFinalSize = bytesCompress.length;
          if (imgFinalSize > maxFileSize) {
            scaffoldMessage.showSnackBar(
              SnackBar(
                content: Text(
                  'File size exceeds 1 MB. Please select a smaller file.',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          try {
            final description = descriptionController.text;
            await uploadProvider.upload(bytesCompress, fileName, description);

            final response = uploadProvider.uploadStoryResponse;
            if (response != null) {
              provider.setImageFile(null);
              provider.setImagePath('');
            }

            bool? result = response?.error;
            if (!(result!)) {
              scaffoldMessage.showSnackBar(
                SnackBar(
                  content: Text(
                    'Upload Success: ${response?.message}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context
                    .read<StoryListProvider>()
                    .fetchStoryList(); // Refresh data
                widget.onPostStory();
              });
            } else {
              scaffoldMessage.showSnackBar(
                SnackBar(
                  content: Text(
                    'Upload Failed: ${response?.message}',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } catch (error) {
            scaffoldMessage.showSnackBar(
              SnackBar(
                content: Text(
                  'Upload Story Error: $error',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const Text('Upload', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
