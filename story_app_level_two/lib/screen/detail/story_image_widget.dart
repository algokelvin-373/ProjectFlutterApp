import 'package:flutter/material.dart';

class StoryImageWidget extends StatelessWidget {
  final String linkImage;

  const StoryImageWidget({super.key, required this.linkImage});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [Hero(tag: linkImage, child: _loadImage())]),
    );
  }

  Widget _loadImage() {
    return FadeInImage.assetNetwork(
      placeholder: 'images/blocks.gif',
      image: linkImage,
      fadeInDuration: const Duration(seconds: 2),
      fadeOutDuration: const Duration(seconds: 2),
    );
    // It's not work for show Image because not match when show photos
    /*return CachedNetworkImage(
      cacheKey: "cache-key",
      imageUrl: linkImage,
      imageBuilder: (context, imageProvider) => Image(image: imageProvider),
      progressIndicatorBuilder:
          (context, url, progress) => Center(
            child: CircularProgressIndicator(value: progress.progress),
          ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );*/
  }
}
