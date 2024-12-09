import 'package:flutter/material.dart';
import 'package:quotes_app/screen/form_screen.dart';
import 'package:quotes_app/screen/quote_detail_screen.dart';
import 'package:quotes_app/screen/quotes_list_screen.dart';

import '../model/quote.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  final GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate(): _navigatorKey = GlobalKey<NavigatorState>();

  String? selectedQuote;
  bool isForm = false;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey("QuotesListScreen"),
          child: QuotesListScreen(
              quotes: quotes,
              onTapped: (String quoteId) {
                selectedQuote = quoteId;
                notifyListeners();
              },
            toFormScreen: () {
                isForm = true;
                notifyListeners();
            },
          ),
        ),
        if (selectedQuote != null)
          MaterialPage(
            key: ValueKey("QuoteDetailsScreen-$selectedQuote"),
            child: QuoteDetailsScreen(
              quoteId: selectedQuote!,
            ),
          ),
        if (isForm)
          MaterialPage(
            key: ValueKey("FormScreen"),
            child: FormScreen(
              onSend: () {
                isForm = false;
                notifyListeners();
              },
            ),
          ),
      ],
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

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