import 'package:flutter/material.dart';
import 'package:quotes_app/screen/quote_detail_screen.dart';
import 'package:quotes_app/screen/quotes_list_screen.dart';

import '../model/quote.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  final GlobalKey<NavigatorState> _navigatorKey;

  MyRouterDelegate(): _navigatorKey = GlobalKey<NavigatorState>();

  String? selectedQuote;

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
              }),
        ),
        if (selectedQuote != null)
          MaterialPage(
            key: ValueKey("QuoteDetailsScreen-$selectedQuote"),
            child: QuoteDetailsScreen(
              quoteId: selectedQuote!,
            ),
          ),
      ],
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        selectedQuote = null;
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