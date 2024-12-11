import '../data/model/story/story.dart';

sealed class StoryListResultState {}

class StoryListNoneState extends StoryListResultState {}

class StoryListLoadingState extends StoryListResultState {}

class StoryListErrorState extends StoryListResultState {
  final String error;

  StoryListErrorState(this.error);
}

class StoryListLoadedState extends StoryListResultState {
  final List<Story> data;

  StoryListLoadedState(this.data);
}
