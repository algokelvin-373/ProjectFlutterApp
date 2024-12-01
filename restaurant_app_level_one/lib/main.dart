import 'package:flutter/material.dart';
import 'package:restaurant_app_level_one/screen/home/home_screen.dart';
import 'package:restaurant_app_level_one/style/typography/restaurant_theme.dart';

import 'static/navigation_route.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.homeRoute.name,
      routes: {
        NavigationRoute.homeRoute.name: (context) => const HomeScreen(),
      },
    );
  }
}
