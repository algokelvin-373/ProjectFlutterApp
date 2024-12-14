import 'package:flutter/material.dart';
import 'package:story_app_level_two/data/model/page_configuration.dart';
import 'package:story_app_level_two/db/auth_repository.dart';
import 'package:story_app_level_two/screen/detail/detail_screen.dart';
import 'package:story_app_level_two/screen/main/main_screen.dart';
import 'package:story_app_level_two/screen/post_story/post_story_screen.dart';
import 'package:story_app_level_two/screen/register/register_screen.dart';

import '../screen/login/login_screen.dart';
import '../screen/splash/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  MyRouterDelegate(this.authRepository)
    : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  List<Page> historyStack = [];

  String? selectedStory;
  bool refreshHomeScreen = false;
  bool postStoryPage = false;
  bool isForm = false;
  bool? isLoggedIn;
  bool isRegister = false;
  bool? isUnknown;

  List<Page> get _splashStack => const [
    MaterialPage(key: ValueKey("SplashPage"), child: SplashScreen()),
  ];

  List<Page> get _loggedOutStack => [
    MaterialPage(
      key: const ValueKey("LoginPage"),
      child: LoginScreen(
        onLogin: () {
          isLoggedIn = true;
          notifyListeners();
        },
        onRegister: () {
          isRegister = true;
          notifyListeners();
        },
      ),
    ),
    if (isRegister == true)
      MaterialPage(
        child: RegisterScreen(
          onLogin: () {
            isRegister = false;
            notifyListeners();
          },
          onRegister: () {
            isRegister = false;
            notifyListeners();
          },
        ),
      ),
  ];

  List<Page> get _loggedInStack => [
    MaterialPage(
      key: const ValueKey("StoryListPage"),
      child: MainScreen(
        onTapped: (String storyId) {
          selectedStory = storyId;
          notifyListeners();
        },
        onLogout: () {
          isLoggedIn = false;
          notifyListeners();
        },
        onPostStory: () {
          postStoryPage = true;
          notifyListeners();
        },
        onRefreshHomeScreen: () {
          if (isLoggedIn == true) {
            notifyListeners();
          }
        },
      ),
    ),
    if (selectedStory != null)
      MaterialPage(
        key: ValueKey(selectedStory),
        child: DetailScreen(storyId: selectedStory!),
      ),
    if (postStoryPage)
      MaterialPage(
        key: const ValueKey("PostStoryPage"),
        child: PostStoryScreen(
          onPostStory: () {
            postStoryPage = false;
            refreshHomeScreen = true;
            notifyListeners();
          },
        ),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;
        selectedStory = null;
        postStoryPage = false;
        isForm = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
      isRegister = false;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isHomePage ||
        configuration.isLoginPage ||
        configuration.isSplashPage) {
      isUnknown = false;
      selectedStory = null;
      isRegister = false;
    } else if (configuration.isDetailPage) {
      isUnknown = false;
      isRegister = false;
      selectedStory = configuration.quoteId.toString();
    } else {}
    notifyListeners();
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfiguration.splash();
    } else if (isRegister == true) {
      return PageConfiguration.register();
    } else if (isLoggedIn == false) {
      return PageConfiguration.login();
    } else if (isUnknown == true) {
      return PageConfiguration.unknown();
    } else if (selectedStory == null) {
      return PageConfiguration.home();
    } else if (selectedStory != null) {
      return PageConfiguration.detailQuote(selectedStory!);
    } else {
      return null;
    }
  }
}
