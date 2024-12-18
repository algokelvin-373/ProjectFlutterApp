import 'package:flutter/material.dart';

class StoryImageWidget extends StatelessWidget {
  final String linkImage;

  const StoryImageWidget({super.key, required this.linkImage});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Hero(tag: linkImage, child: _loadImage())]);
  }

  Widget _loadImage() {
    return FadeInImage.assetNetwork(
      placeholder: 'images/blocks.gif',
      image: linkImage,
      fadeInDuration: const Duration(seconds: 2),
      fadeOutDuration: const Duration(seconds: 2),
    );
  }
}
