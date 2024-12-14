import 'package:cached_network_image/cached_network_image.dart';
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
        print('Card tapped! ${story.id}');
        onTapped(story.id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: CachedNetworkImage(
              cacheKey: "cache-key",
              imageUrl: story.photoUrl,
              imageBuilder: (context, imageProvider) => ClipOval(
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(value: progress.progress),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ],
    );
  }

  Widget bodyStoryWidget() {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              story.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
