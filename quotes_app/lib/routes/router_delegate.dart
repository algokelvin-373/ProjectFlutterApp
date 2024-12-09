import 'package:flutter/material.dart';
import 'package:quotes_app/db/auth_repository.dart';
import 'package:quotes_app/screen/login_screen.dart';
import 'package:quotes_app/screen/quote_detail_screen.dart';
import 'package:quotes_app/screen/quotes_list_screen.dart';
import 'package:quotes_app/screen/register_screen.dart';
import 'package:quotes_app/screen/splash_screen.dart';

import '../model/quote.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  MyRouterDelegate(this.authRepository) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  List<Page> historyStack = [];

  String? selectedQuote;
  bool isForm = false;
  bool? isLoggedIn;
  bool isRegister = false;

  List<Page> get _splashStack => const [
    MaterialPage(
      key: ValueKey("SplashPage"),
      child: SplashScreen(),
    ),
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
        key: const ValueKey("RegisterPage"),
        child: RegisterScreen(
          onRegister: () {
            isRegister = false;
            notifyListeners();
          },
          onLogin: () {
            isRegister = false;
            notifyListeners();
          },
        ),
      ),
  ];

  List<Page> get _loggedInStack => [
    MaterialPage(
      key: const ValueKey("QuotesListPage"),
      child: QuotesListScreen(
        quotes: quotes,
        onTapped: (String quoteId) {
          selectedQuote = quoteId;
          notifyListeners();
        },
        onLogout: () {
          isLoggedIn = false;
          notifyListeners();
        },
      ),
    ),
    if (selectedQuote != null)
      MaterialPage(
        key: ValueKey(selectedQuote),
        child: QuoteDetailsScreen(
          quoteId: selectedQuote!,
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
        selectedQuote = null;
        isForm = false;
        notifyListeners();

        return true;
      },
    );
  }


  @override
  Future<void> setNewRoutePath(configuration) async {
    /*Do Nothing*/
  }
}