import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  late GoogleMapController mapController;
  LatLng? myPlace;
  late dynamic lat, lng;
  final Set<Marker> markers = {};
  String address = "Loading address...";

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

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check service location is ON
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }

    // Check permission location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get Location Now
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      myPlace = LatLng(position.latitude, position.longitude);
      markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: myPlace!,
          infoWindow: InfoWindow(title: "Your Location"),
        ),
      );
    });

    // Convert coordinate to address
    _getAddressFromLatLng(myPlace!.latitude, myPlace!.longitude);
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placeMarks[0];

      setState(() {
        address = "${place.street}, "
            "${place.subLocality}, "
            "${place.locality}, "
            "${place.country}";
      });
    } catch (e) {
      setState(() {
        address = "Unable to get address: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
              Text(
                "Current Address: $address",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (myPlace != null)
                SizedBox(
                  height: 300,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      zoom: 18,
                      target: myPlace!,
                    ),
                    markers: markers,
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    onTap: (tappedPosition) {
                      setState(() {
                        myPlace = tappedPosition;
                        markers.clear();
                        markers.add(
                          Marker(
                            markerId: const MarkerId('selectedLocation'),
                            position: tappedPosition,
                            draggable: true,
                            onDragEnd: (LatLng newPosition) {
                              setState(() {
                                myPlace = newPosition;
                              });
                              _getAddressFromLatLng(
                                newPosition.latitude,
                                newPosition.longitude,
                              );
                            }
                          ),
                        );
                      });
                      _getAddressFromLatLng(
                          tappedPosition.latitude,
                          tappedPosition.longitude,
                      );
                    },
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

            print ('Jalan');
            final dataLat = myPlace!.latitude;
            final dataLng = myPlace!.longitude;
            if (dataLat == 0.0 && dataLng == 0.0) {
              print ('Jalan 1');
              await uploadProvider.upload(bytesCompress, fileName, description);
            } else {
              print ('Jalan 2');
              await uploadProvider.upload(
                  bytesCompress, fileName, description, dataLat, dataLng);
            }

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
