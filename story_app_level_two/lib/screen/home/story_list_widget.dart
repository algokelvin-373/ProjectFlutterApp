import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/story/story.dart';
import '../../provider/home/story_list_provider.dart';
import '../../static/story_list_result.dart';
import 'story_item_card_widget.dart';

class StoryListWidget extends StatefulWidget {
  final Function(String) onTapped;

  const StoryListWidget({super.key, required this.onTapped});

  @override
  State<StoryListWidget> createState() => _StoryListWidgetState();
}

class _StoryListWidgetState extends State<StoryListWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = context.read<StoryListProvider>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (provider.pageItems != null) {
          provider.fetchStoryListPagination();
        }
      }
    });

    Future.microtask(() => provider.fetchStoryListPagination());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getStoryList();
  }

  Widget _getStoryList() {
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
      if (storyList.isEmpty) {
        // If data is empty
        return _showMessageListStoryEmpty();
      } else {
        // For show list story
        return _showListStory(storyList, list.pageItems);
      }
    } else if (list.resultState is StoryListErrorState) {
      final message = (list.resultState as StoryListErrorState).error;
      return _actionErrorDialog(message);
    } else {
      return const SizedBox();
    }
  }

  Widget _showMessageListStoryEmpty() {
    return Center(
      child: Text(
        'List Story is Empty',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  Widget _showListStory(List<Story> storyList, int? valuePageItems) {
    return ListView.builder(
      key: const ValueKey("listStory"),
      controller: scrollController,
      itemCount: storyList.length + (valuePageItems != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == storyList.length && valuePageItems != null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final story = storyList[index];
        return StoryItemCardWidget(story: story, onTapped: widget.onTapped);
      },
    );
  }

  Widget _actionErrorDialog(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showErrorDialog(message, () {
        context.read<StoryListProvider>().fetchStoryListPagination();
        //_checkInternetConnection();
      });
    });
    return const Center(child: Text("Error loading data."));
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
              Text(message, style: const TextStyle(fontSize: 14)),
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
