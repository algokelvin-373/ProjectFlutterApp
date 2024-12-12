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
              imageBuilder: (context, imageProvider) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, progress) => SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(value: progress.progress),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                child: const Icon(Icons.error, size: 40),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bodyStoryWidget() {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
