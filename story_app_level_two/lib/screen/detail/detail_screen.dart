import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/detail/story_detail_provider.dart';
import '../../static/story_detail_result.dart';
import 'detail_screen_body_widget.dart';

class DetailScreen extends StatefulWidget {
  final String storyId;

  const DetailScreen({
    super.key,
    required this.storyId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<RestaurantDetailProvider>()
          .fetchRestaurantDetail(widget.storyId);
    });
  }

  void _showErrorDialog(String message, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text('Error Message'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context
                      .read<RestaurantDetailProvider>()
                      .fetchRestaurantDetail(id); // Refresh data
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (_, value, __) {
          if (value.resultState is StoryDetailLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.resultState is StoryDetailLoadedState) {
            final storyDetail = (value.resultState as StoryDetailLoadedState).data;
            return DetailScreenBodyWidget(storyDetail: storyDetail);
          } else if (value.resultState is StoryDetailErrorState) {
            final message =
                (value.resultState as StoryDetailErrorState).error;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showErrorDialog(message, widget.storyId);
            });
            return const Center(child: Text("Error loading data."));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
