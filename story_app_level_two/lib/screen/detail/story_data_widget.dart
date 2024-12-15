import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.storyDetail!.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        spaceVertical(15),
        Row(
          children: [
            IconText(
              icon: Icons.date_range,
              label: widget.storyDetail!.createdAt.toString(),
            ),
          ],
        ),
        spaceVertical(20),
        Text(
          widget.storyDetail!.description,
          style: const TextStyle(fontSize: 14),
        ),
        spaceVertical(15),
      ],
    );
  }
}
