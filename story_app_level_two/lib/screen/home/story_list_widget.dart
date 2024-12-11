import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home/story_list_provider.dart';
import '../../static/story_list_result.dart';
import 'story_item_card_widget.dart';

class StoryListWidget extends StatefulWidget {
  const StoryListWidget({
    super.key,
  });

  @override
  State<StoryListWidget> createState() => _StoryListWidgetState();
}

class _StoryListWidgetState extends State<StoryListWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<StoryListProvider>().fetchStoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<StoryListProvider>(
        builder: (context, list, child) {
          return _widgetListStory(list);
        },
      ),
    );
  }

  Widget _widgetListStory(StoryListProvider list) {
    if (list.resultState is StoryListLoadingState) {
      return const Center(
        child: CircularProgressIndicator(key: ValueKey("loadingIndicatorAll")),
      );
    } else if (list.resultState is StoryListLoadedState) {
      final storyList = (list.resultState as StoryListLoadedState).data;
      return GridView.builder(
        key: const ValueKey("gridStory"),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.65,
        ),
        itemCount: storyList.length,
        itemBuilder: (context, index) {
          final story = storyList[index];
          return StoryItemCardWidget(story: story);
        },
      );
    } else if (list.resultState is StoryListErrorState) {
      final message = (list.resultState as StoryListErrorState).error;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(message, () {
          context.read<StoryListProvider>().fetchStoryList(); // Refresh data
        });
      });
      return const Center(child: Text("Error loading data."));
    } else {
      return const SizedBox();
    }
  }

  void _showErrorDialog(String message, VoidCallback onRefresh) {
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
                  onRefresh(); // Call refresh action
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        );
      },
    );
  }
}
