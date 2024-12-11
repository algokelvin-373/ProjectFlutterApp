import 'package:flutter/material.dart';
import 'package:story_app_level_two/data/model/story/story.dart';

import '../../static/navigation_route.dart';
import '../../utils/global_function.dart';

class StoryItemCardWidget extends StatelessWidget {
  final Story story;

  const StoryItemCardWidget({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: verticalSymmetric(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Hero(
              tag: story.photoUrl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  story.photoUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            spaceHorizontal(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    key: const ValueKey("textRestaurantName"),
                    story.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  spaceVertical(5),
                  Text(
                    story.description,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceVertical(5),
                  /*Text(
                    story.rating.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                ],
              ),
            ),
            // Add Cart Button
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    NavigationRoute.detailRoute.name,
                    arguments: story.id,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  'Visit',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
