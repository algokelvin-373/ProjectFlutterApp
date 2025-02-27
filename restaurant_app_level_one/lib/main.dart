import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_level_one/data/api/api_services.dart';
import 'package:restaurant_app_level_one/data/local/db_service.dart';
import 'package:restaurant_app_level_one/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app_level_one/provider/detail/restaurant_review_provider.dart';
import 'package:restaurant_app_level_one/provider/favorite/db_provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_level_one/provider/home/restaurant_search_provider.dart';
import 'package:restaurant_app_level_one/provider/main/index_nav_provider.dart';
import 'package:restaurant_app_level_one/provider/notification/notification_provider.dart';
import 'package:restaurant_app_level_one/provider/theme/theme_provider.dart';
import 'package:restaurant_app_level_one/screen/main/main_screen.dart';
import 'package:restaurant_app_level_one/service/notification_service.dart';
import 'package:restaurant_app_level_one/style/typography/restaurant_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen/detail/detail_screen.dart';
import 'static/navigation_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await NotificationService.requestNotificationPermission();
  final prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiServices(),
        ),
        Provider(
          create: (context) => DbService(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantReviewProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DbProvider(
            context.read<DbService>()),
        ),
      ],
      child: RestaurantApp(isDarkMode: isDarkMode),
    ),
  );
}

class RestaurantApp extends StatelessWidget {
  final bool isDarkMode;

  const RestaurantApp({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, value, __) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: value.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId: ModalRoute.of(context)?.settings.arguments as String,
            ),
          },
        );
      },
    );
  }
}