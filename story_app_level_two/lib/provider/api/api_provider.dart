import 'package:flutter/material.dart';
import 'package:story_app_level_two/data/api/api_services.dart';
import 'package:story_app_level_two/data/model/api_state.dart';
import 'package:story_app_level_two/data/model/story/story.dart';

class ApiProvider extends ChangeNotifier {
  final ApiServices apiServices;

  ApiProvider(this.apiServices);

  ApiState storiesState = ApiState.initial;

  String storiesMessage = "";
  bool storiesError = false;
  List<Story> stories = [];
  int? pageItems = 1;
  int sizeItems = 10;

  Future<void> getStories() async {
    try {
      if (pageItems == 1) {

      }
    } catch (e) {

    }
  }
}