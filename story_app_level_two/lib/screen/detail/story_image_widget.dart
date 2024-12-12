import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoryImageWidget extends StatelessWidget {
  final String linkImage;

  const StoryImageWidget({
    super.key,
    required this.linkImage,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(linkImage),
        background: Hero(
          tag: linkImage,
          child: CachedNetworkImage(
            cacheKey: "cache-key",
            imageUrl: linkImage,
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
    );
  }
}
