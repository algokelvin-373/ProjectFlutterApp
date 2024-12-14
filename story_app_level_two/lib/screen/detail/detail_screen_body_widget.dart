import 'package:flutter/material.dart';
import 'package:story_app_level_two/data/model/story/story.dart';

import 'story_data_widget.dart';
import 'story_image_widget.dart';

class DetailScreenBodyWidget extends StatelessWidget {
  final Story? storyDetail;

  const DetailScreenBodyWidget({super.key, required this.storyDetail});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StoryImageWidget(linkImage: storyDetail!.photoUrl),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              //color: Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: StoryDataWidget(storyDetail: storyDetail),
          ),
        ],
      ),
    );
  }
}
