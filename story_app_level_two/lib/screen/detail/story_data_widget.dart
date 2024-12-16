import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    lat = widget.storyDetail?.lat ?? 0.0;
    lng = widget.storyDetail?.lon ?? 0.0;
    myPlace = LatLng(lat, lng);
    final marker = Marker(
      markerId: const MarkerId("myPlace"),
      position: myPlace,
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(myPlace, 18),
        );
      },
    );
    markers.add(marker);
  }

  @override
  Widget build(BuildContext context) {
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
        (lat == 0.0 && lng == 0.0) ? const SizedBox() : _mapLocationWidget(),
      ],
    );
  }

  Widget _mapLocationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: 500,
          child: GoogleMap(
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, lng),
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
      ],
    );
  }
}
