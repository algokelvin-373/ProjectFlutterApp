import 'package:flutter/material.dart';

import '../../data/api/api_services.dart';
import '../../db/auth_repository.dart';
import '../../static/restaurant_list_result.dart';

class StoryListProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiServices _apiServices;

  StoryListProvider(this._apiServices, this.authRepository);

  StoryListResultState _resultState = StoryListNoneState();

  StoryListResultState get resultState => _resultState;

  void setResultState(StoryListResultState state) {
    _resultState = state;
    notifyListeners();
  }

  Future<void> fetchStoryList() async {
    _resultState = StoryListLoadingState();
    notifyListeners();

    try {
      String token = await authRepository.getToken();
      print('Token: $token');
      final result = await _apiServices.getStoryList(token);

      if (result.error) {
        _resultState = StoryListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = StoryListLoadedState(result.listStory);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = StoryListErrorState(e.toString());
      notifyListeners();
    }
  }
}
