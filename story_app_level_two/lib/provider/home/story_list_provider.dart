import 'package:flutter/material.dart';
import 'package:story_app_level_two/data/model/api_state.dart';

import '../../data/api/api_services.dart';
import '../../data/model/story/story.dart';
import '../../db/auth_repository.dart';
import '../../static/story_list_result.dart';

class StoryListProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final ApiServices _apiServices;

  StoryListProvider(this._apiServices, this._authRepository);

  StoryListResultState _resultState = StoryListNoneState();

  StoryListResultState get resultState => _resultState;

  ApiState storiesState = ApiState.initial;

  String storiesMessage = "";
  bool storiesError = false;
  List<Story> stories = [];
  int? pageItems = 1;
  int sizeItems = 10;

  void setResultState(StoryListResultState state) {
    _resultState = state;
    notifyListeners();
  }

  /*Future<void> fetchStoryList() async {
    _resultState = StoryListLoadingState();
    notifyListeners();

    try {
      String token = await _authRepository.getToken();
      final result = await _apiServices.getStoryList(token);

      if (result.error) {
        _resultState = StoryListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = StoryListLoadedState(result.listStory);
        notifyListeners();
      }
    } on Exception catch (e) {
      final message = "Failed to Get List Story";
      _resultState = StoryListErrorState(message);
      notifyListeners();
    }
  }*/

  Future<void> fetchStoryListPagination() async {
    try {
      if (pageItems == 1) {
        _resultState = StoryListLoadingState();
        notifyListeners();
        // storiesState = ApiState.loading;
        // notifyListeners();
      }

      String token = await _authRepository.getToken();
      final result =
          await _apiServices.getStoryList(token, pageItems, sizeItems);

      if (result.error) {
        print('Error');
        _resultState = StoryListErrorState(result.message);
        notifyListeners();
      } else {
        print('Masuk Get Else');
        stories.addAll(result.listStory);
        _resultState = StoryListLoadedState(stories);
        // storiesMessage = "Success";
        // storiesError = false;
        // storiesState = ApiState.loaded;

        if (result.listStory.length < sizeItems) {
          pageItems = null;
        } else {
          pageItems = pageItems! + 1;
        }
        notifyListeners();
      }
    } catch (e) {
      final message = "Failed to Get List Story";
      _resultState = StoryListErrorState(message);
      notifyListeners();

      // storiesState = ApiState.error;
      // storiesError = true;
      // storiesMessage = "Get Stories Failed";
      // notifyListeners();
    }
  }
}
