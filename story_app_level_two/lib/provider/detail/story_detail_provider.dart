import 'package:flutter/material.dart';

import '../../data/api/api_services.dart';
import '../../db/auth_repository.dart';
import '../../static/story_detail_result.dart';

class StoryDetailProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  final ApiServices _apiServices;

  StoryDetailProvider(
    this._authRepository,
    this._apiServices,
  );

  StoryDetailResultState _resultState = StoryDetailNoneState();

  StoryDetailResultState get resultState => _resultState;

  Future<void> fetchStoryDetail(String id) async {
    try {
      _resultState = StoryDetailLoadingState();
      notifyListeners();

      String token = await _authRepository.getToken();
      final result = await _apiServices.getStoryDetail(token, id);

      if (result.error) {
        _resultState = StoryDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = StoryDetailLoadedState(result.story);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = StoryDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
