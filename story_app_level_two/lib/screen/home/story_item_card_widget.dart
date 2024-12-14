import 'package:flutter/material.dart';
import 'package:story_app_level_two/data/model/story/story.dart';

import '../../utils/global_function.dart';

class StoryItemCardWidget extends StatelessWidget {
  final Story story;
  final Function(String) onTapped;

  const StoryItemCardWidget({
    super.key,
    required this.story,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapped(story.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          children: [
            photoWidget(),
            spaceVertical(8),
            bodyStoryWidget(),
            spaceVertical(12),
          ],
        ),
      ),
    );
  }

  Widget photoWidget() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: FadeInImage.assetNetwork(
              placeholder: 'images/blocks.gif',
              image: story.photoUrl,
              fadeInDuration: const Duration(seconds: 2),
              fadeOutDuration: const Duration(seconds: 2),
              height: 100,
              width: 100,
            ),
          ),
        ),
      ],
    );
  }

  Widget bodyStoryWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              story.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
