import 'package:flutter/material.dart';
import 'package:wisata_app_level_two/model/tourism.dart';

class TourismCardWidget extends StatelessWidget {
  const TourismCardWidget({
    super.key,
    required this.tourism,
  });

  final Tourism tourism;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tourism.name,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            tourism.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}