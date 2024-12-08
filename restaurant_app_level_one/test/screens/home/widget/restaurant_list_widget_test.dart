import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/data/model/restaurant.dart';
import 'package:restaurant_app_level_one/main.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app_level_one/provider/main/index_nav_provider.dart';
import 'package:restaurant_app_level_one/provider/notification/notification_provider.dart';
import 'package:restaurant_app_level_one/provider/theme/theme_provider.dart';
import 'package:restaurant_app_level_one/static/restaurant_list_result.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(RestaurantListLoadingState());
  });

  testWidgets('Should Return Restaurant List', (tester) async {
    final apiServices = ApiServices();

    final mockListRestaurant = [
      Restaurant(
        id: 'rqdv5juczeskfw1e867',
        name: 'Melting Pot',
        description: 'Lorem ipsum dolor sit amet...',
        pictureId: '14',
        city: 'Medan',
        rating: 4.2,
      ),
      Restaurant(
        id: 's1knt6za9kkfw1e867',
        name: 'Kafe Kita',
        description: 'Quisque rutrum...',
        pictureId: '25',
        city: 'Gorontalo',
        rating: 4.0,
      ),
    ];

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => IndexNavProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
          ChangeNotifierProvider(
              create: (_) => RestaurantListProvider(apiServices)),
          ChangeNotifierProvider(
              create: (_) => RestaurantSearchProvider(apiServices)),
        ],
        child: const RestaurantApp(isDarkMode: true),
      ),
    );

    await tester.pumpAndSettle();
  });
}