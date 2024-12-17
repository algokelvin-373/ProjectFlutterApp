import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app_level_two/data/model/story/story.dart';

import '../../utils/global_function.dart';
import 'icon_text.dart';

class StoryDataWidget extends StatefulWidget {
  final Story? storyDetail;

  const StoryDataWidget({super.key, required this.storyDetail});

  @override
  State<StoryDataWidget> createState() => _StoryDataWidgetState();
}

class _StoryDataWidgetState extends State<StoryDataWidget> {
  late GoogleMapController mapController;
  late LatLng myPlace;
  late dynamic lat, lng;
  final Set<Marker> markers = {};
  String? currentAddress;

  @override
  void initState() {
    super.initState();
    lat = widget.storyDetail?.lat ?? 0.0;
    lng = widget.storyDetail?.lon ?? 0.0;
    myPlace = LatLng(lat, lng);
    final marker = Marker(
      markerId: const MarkerId("myPlace"),
      position: myPlace,
      onTap: () async {
        await _updateAddress(myPlace);
      },
    );
    markers.add(marker);
  }

  Future<void> _updateAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          currentAddress = "${place.street}, "
              "${place.locality}, "
              "${place.administrativeArea}, "
              "${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        currentAddress = "Failed to Get Address";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.storyDetail!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.storyDetail?.name ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        spaceVertical(15),
        Row(
          children: [
            IconText(
              icon: Icons.date_range,
              label: widget.storyDetail?.createdAt.toString() ?? '',
            ),
          ],
        ),
        spaceVertical(20),
        Text(
          widget.storyDetail?.description ?? '',
          style: const TextStyle(fontSize: 14),
        ),
        spaceVertical(15),
        (story.lat == null && story.lon == null)
            ? const SizedBox()
            : _mapLocationWidget(),
      ],
    );
  }

  Widget _mapLocationWidget() {
    return Stack(
      children: [
        SizedBox(
          height: 500,
          child: GoogleMap(
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.storyDetail!.lat, widget.storyDetail!.lon),
              zoom: 18,
            ),
            mapType: MapType.normal,
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
          ),
        ),
        if (currentAddress != null)
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                currentAddress!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
